class PublishersitesController < ApplicationController
 	layout 'createpublisher'

  def index
		if params[:type].present?
			if params[:type] == "all"
				@status = "All"
				@pubSites = Publishersite.where(created_by: session[:user_id])
			elsif params[:type] == "active"
				@status = "Active"
				@pubSites = Publishersite.where(created_by: session[:user_id] , status: 'Active')
			elsif params[:type] == "inactive"
				@status = "Inactive"
				@pubSites = Publishersite.where(created_by: session[:user_id] , status: 'Paused')
			end
		else
			@status = ""
			@pubSites = Publishersite.where(created_by: session[:user_id])
		end
		@pubAllSites = Publishersite.where(created_by: session[:user_id])
  	@sites = Publishersite.where(created_by: session[:user_id] , status: 'Active')
			if @pubAllSites.count > 0 
				if @sites.count == 0 && @pubSites.count > 0
					if flash[:notice].present?
						flash[:notice] = "Please re-activate any site."
					end
				end
			else
				redirect_to "/publishers/introduction?page=1"
			end
  end

  def myads
  end

	def changestatus
  	@sites = Publishersite.where(created_by: session[:user_id] , status: 'Active')
		if params[:option] == 'active' || params[:option] == 'deactive'
			@site = Publishersite.find(params[:id])
			if params[:option] == 'active'
				@statusVlue = "Activated"
				@qwert = @site.update_attribute(:status , 'Active')
			else
				@statusVlue = "Deactivated"
				@qwert = @site.update_attribute(:status , 'Paused')
				if params[:id].to_i == session[:publishersite_id].to_i
					session[:publishersite_name] = ""
					session[:publishersite_id] = ""
					session[:publishersite_url] = ""
					@Publishersites = Publishersite.where(created_by: session[:user_id] , status: 'Active').limit(1).order('id asc')
					sitesCount = @Publishersites.count
					if sitesCount == 1
						@Publishersites.each do |psitei|
							session[:publishersite_name] = psitei.website_title
							session[:publishersite_id] = psitei.id
							session[:publishersite_url] = psitei.website_url
						end
					else
						session[:publishersite_name] = ""
						session[:publishersite_id] = ""
						session[:publishersite_url] = ""
					end
				end
			end
			flash[:notice] = "Site " + @site.website_title + " has been " + @statusVlue
			redirect_to publishersites_path
		else
			flash[:notice] = "Url is broken."
			redirect_to publishersites_path
		end
	end

  def renderedpagetodisplay
  end
  def new
  	@publishersite = Publishersite.new
  	@sites =Publishersite.where(created_by: session[:user_id] , status: 'Active')
  	@allsites =Publishersite.all
  end
  def create
  @sites =Publishersite.where(created_by: session[:user_id] , status: 'Active')
		require 'net/http'
		cusUrl = params[:publishersite][:website_url]
				begin
				    uri = URI.parse(cusUrl)
				    http = Net::HTTP.new(uri.host, uri.port)

				    if cusUrl =~ /^https/
					  	http.use_ssl = true
							http.verify_mode = OpenSSL::SSL::VERIFY_NONE
						end
				    request = Net::HTTP::Get.new(uri.request_uri)
=begin
				    #This makes the request
						http.use_ssl = true if cusUrl =~ /^https/
						http.verify_mode = OpenSSL::SSL::VERIFY_NONE
				    request = Net::HTTP::Get.new(uri.request_uri)
=end
				    resp = http.request(request)
				
					rescue URI::InvalidURIError => se
					setSessions(params)
						@publishersite = Publishersite.new
						@sites =Publishersite.where(created_by: session[:user_id] , status: 'Active')
						flash[:notice] = "Invalid Url"
						redirect_to "/publishersites/new"
					rescue SocketError => se
					setSessions(params)
						@publishersite = Publishersite.new
						@sites =Publishersite.where(created_by: session[:user_id] , status: 'Active')
						flash[:notice] = "Url is broken, please give a valid one.SocketError received"
						redirect_to "/publishersites/new"
				rescue Errno::ETIMEDOUT => se
					setSessions(params)
						@publishersite = Publishersite.new
						@sites =Publishersite.where(created_by: session[:user_id] , status: 'Active')
						flash[:notice] = "Url is broken, please give a valid one.Request TimedOut !"
						redirect_to "/publishersites/new"
				rescue Errno::ECONNREFUSED=>se
					setSessions(params)
						@publishersite = Publishersite.new
						@sites =Publishersite.where(created_by: session[:user_id] , status: 'Active')
						flash[:notice] = "Url is broken, please give a valid one.Server refused the connection !"
						redirect_to "/publishersites/new"
				rescue Errno::ECONNRESET => se
						@publishersite = Publishersite.new(params[:publishersite])
						revert = "no"
						if @publishersite.save
							destroySessions
							if session[:usertype]=="advertiser"
								User.where("`users`.`id` = '#{session[:user_id]}'").update_all(:userType => "both")
								session[:usertype]="both"
							end
						end
						@Publishersites=Publishersite.where(created_by: session[:user_id] , status: 'Active').limit(1).order('id desc')
						sitesCount = @Publishersites.count
						#if sitesCount == 1
							revert = "yes"
							@Publishersites.each do |psitei|
								session[:publishersite_name] = psitei.website_title
								session[:publishersite_id] = psitei.id
								session[:publishersite_url] = psitei.website_url
							end
						#end
						if revert == "yes"
							redirect_to "/placements/creatingadunits?aft=1"	
						else
							if $redirectTo == ""
								redirect_to publishersites_path
							else 
								redirectUrl = $redirectTo
								$redirectTo = ""
								redirect_to "#{redirectUrl}"
							end
						end
				else
					if resp.code[0] != "4" && resp.code != "0"
						@publishersite = Publishersite.new(params[:publishersite])
						revert = "no"
						if @publishersite.save
							destroySessions
							if session[:usertype]=="advertiser"
								User.where("`users`.`id` = '#{session[:user_id]}'").update_all(:userType => "both")
								session[:usertype]="both"
							end
						end
						@Publishersites=Publishersite.where(created_by: session[:user_id] , status: 'Active').limit(1).order('id desc')
						sitesCount = @Publishersites.count
						#if sitesCount == 1
							revert = "yes"
							@Publishersites.each do |psitei|
								session[:publishersite_name] = psitei.website_title
								session[:publishersite_id] = psitei.id
								session[:publishersite_url] = psitei.website_url
							end
						#end
						if revert == "yes"
							redirect_to "/placements/startPlacement"	
						else
							if $redirectTo == ""
								redirect_to publishersites_path
							else 
								redirectUrl = $redirectTo
								$redirectTo = ""
								redirect_to "#{redirectUrl}"
							end
						end
					else
						flash[:notice] = "Url is broken, please give a valid one.Error code #{resp.code} received !"
						redirect_to "/publishersites/new"
					end
				end
  end
  def edit
		begin
			@publishersite = Publishersite.find(params[:id])
			rescue ActiveRecord::RecordNotFound
			render_404
		else
			if @publishersite.created_by != session[:user_id].to_s
				render_404
			end
			@sites = Publishersite.where(created_by: session[:user_id] , status: 'Active')
			@allsites = Publishersite.all
		end
  end
  def update
				@sites = Publishersite.where(created_by: session[:user_id] , status: 'Active')
				siteId = params[:id]
				require 'net/http'
				cusUrl = params[:publishersite][:website_url]
				begin
						uri = URI.parse(cusUrl)
				    http = Net::HTTP.new(uri.host, uri.port)
				    if cusUrl =~ /^https/
					  	http.use_ssl = true
							http.verify_mode = OpenSSL::SSL::VERIFY_NONE
						end
						http.read_timeout = 30
				    request = Net::HTTP::Get.new(uri.request_uri)
				    
				    #This makes the request
				    resp = http.request(request)
				rescue URI::InvalidURIError => se
					setSessions(params)
						@publishersite = Publishersite.new
						@sites =Publishersite.where(created_by: session[:user_id] , status: 'Active')
						flash[:notice] = "Invalid Url"
						redirect_to "/publishersites/#{siteId}/edit"
				rescue SocketError => se
						setSessions(params)
						@publishersite = Publishersite.new
						@sites =Publishersite.where(created_by: session[:user_id] , status: 'Active')
						flash[:notice] = "Url is broken, please give a valid one.SocketError received !"
						redirect_to "/publishersites/#{siteId}/edit"
				rescue Errno::ETIMEDOUT => se
						setSessions(params)
						@publishersite = Publishersite.new
						@sites =Publishersite.where(created_by: session[:user_id] , status: 'Active')
						flash[:notice] = "Url is broken, please give a valid one.Request TimedOut !"
						redirect_to "/publishersites/#{siteId}/edit"
				rescue Errno::ECONNREFUSED=>se
						setSessions(params)
						@publishersite = Publishersite.new
						@sites =Publishersite.where(created_by: session[:user_id] , status: 'Active')
						flash[:notice] = "Url is broken, please give a valid one.Server refused the connection !"
						redirect_to "/publishersites/#{siteId}/edit"
				rescue Errno::ECONNRESET => se
					#setSessions(params)
						@publishersite = Publishersite.find(params[:id])
						if @publishersite.update_attributes(params[:publishersite])
							destroySessions
							flash[:notice] = 'Publisher site was successfully updated.'
							redirect_to(publishersites_path)
						else
							render "edit"
						end
				else
					if resp.code[0] != "4" && resp.code != "0"
						@publishersite = Publishersite.find(params[:id])
						if @publishersite.update_attributes(params[:publishersite])
							destroySessions
							flash[:notice] = 'Publisher site was successfully updated.'
							redirect_to(publishersites_path)
						else
							render "edit"
						end
					else
						flash[:notice] = "Url is broken, please give a valid one.Error code #{resp.code} received !"
						redirect_to "/publishersites/#{siteId}/edit"
					end
				end

  end
  def destroy
		@publishersite = Publishersite.find(params[:id])
		@qwert = @publishersite.update_attribute(:status , 'Deleted')
		if params[:id].to_i == session[:publishersite_id].to_i
				@Publishersites=Publishersite.where(created_by: session[:user_id] , status: 'Active').limit(1).order('id asc')
				sitesCount = @Publishersites.count
				if sitesCount != 0
				  @Publishersites.each do |psitei|
						session[:publishersite_name] = psitei.website_title
						session[:publishersite_id] = psitei.id
						session[:publishersite_url] = psitei.website_url
					end
				else
				  session[:publishersite_name] = ""
				  session[:publishersite_id] = ""
				  session[:publishersite_url] = ""
				end
		end
	  redirect_to publishersites_path
  end
  
  def checkURL
		if params[:siteId].present?
			if Publishersite.where('website_url' =>params[:siteurl] , 'created_by'=>session[:user_id]).where.not('id' => params[:siteId]).count == 0
				render text: 0
			else
				render text: 1
			end
		else
			if Publishersite.where('website_url' =>params[:siteurl] , 'created_by'=>session[:user_id]).count == 0
				render text: 0
			else
				render text: 1
			end
		end
  end
  
  def checkSiteName
		if params[:siteId].present?
			if Publishersite.where('website_title' =>params[:sitename] , 'created_by'=>session[:user_id]).where.not('id' => params[:siteId]).count == 0
				render text: 0
			else
				render text: 1
			end
		else
			if Publishersite.where('website_title' =>params[:sitename] , 'created_by'=>session[:user_id]).count == 0
				render text: 0
			else
				render text: 1
			end
		end
  end

  #### Sites list according to channels
  def siteslist
	if params[:channelId]=='22'
		@channelSitesList = Publishersite.where("id in (?) AND status='Active'",session['adunitsSites'])
	else
		@channelSitesList = Publishersite.where("id in (?) AND channel = (?) AND status='Active'",session['adunitsSites'],params[:channelId])
	end
   @siteDetails=""
   @channelSitesList.each do |site|
   	@siteDetails=@siteDetails + site.id.to_s + "|" +site.website_title.to_s + "|" + site.website_url.to_s + "|" + site.avg_mon_imps.to_s + "|" + site.description + "|"
   end
   render text: @siteDetails
  end
	private
	def setSessions(params)
		session[:website_title] = params[:publishersite][:website_title]
		session[:website_url] = params[:publishersite][:website_url]
		session[:description] = params[:publishersite][:description]
		session[:channel] = params[:publishersite][:channel]
		session[:language] = params[:publishersite][:language]
		session[:avg_mon_imps] = params[:publishersite][:avg_mon_imps]
	end
	def destroySessions
		session.delete(:avg_mon_imps)
		session.delete(:language)
		session.delete(:channel)
		session.delete(:description)
		session.delete(:website_url)
		session.delete(:website_title)
=begin
		session[:website_title] = nil
		session[:website_url] = nil
		session[:description] = nil
		session[:channel] = nil
		session[:language] = nil
		session[:avg_mon_imps] = nil
=end
	end
end
