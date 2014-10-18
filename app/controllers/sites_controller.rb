=begin
  controller for CRUD operations of sites 
=end
class SitesController < ApplicationController
  layout 'advertiser'
  
  #### Code to create site starts here ####
  
  def new
    @sites =Site.where(advertiserId: session[:user_id],siteStatus:"active")
  end
  def create
   @sites =Site.where(advertiserId: session[:user_id],siteStatus:"active")
   
    #render text: params[:retarget].inspect
			require 'net/http'
			cusUrl = params[:site][:siteUrl]
			begin
				uri = URI.parse(cusUrl)
			    http = Net::HTTP.new(uri.host, uri.port)
			    if cusUrl =~ /^https/
					  http.use_ssl = true
						http.verify_mode = OpenSSL::SSL::VERIFY_NONE
					end
			    request = Net::HTTP::Get.new(uri.request_uri)
			    #This makes the request
			    resp = http.request(request)
			rescue URI::InvalidURIError => se
					@site = Site.new
					@sites =Site.where(advertiserId: session[:user_id],siteStatus:"active")
					flash[:error] = "Invalid Url"
					redirect_to "/sites/new"
			rescue SocketError => se
					@site = Site.new
					@sites =Site.where(advertiserId: session[:user_id],siteStatus:"active")
					flash[:error] = "Url is broken, please give a valid one. SocketError received!"
					redirect_to "/sites/new"
			rescue Errno::ETIMEDOUT => se
						@site = Site.new
						@sites =Site.where(advertiserId: session[:user_id],siteStatus:"active")
						flash[:notice] = "Url is broken, please give a valid one. Request TimedOut!"
						redirect_to "/sites/new"
			rescue Errno::ECONNREFUSED=>se
						@site = Site.new
						@sites =Site.where(advertiserId: session[:user_id],siteStatus:"active")
						flash[:notice] = "Url is broken, please give a valid one. Server refused the connection!"
						redirect_to "/sites/new"
				rescue Errno::ECONNRESET => se
					@site = Site.new(params[:site])
					if @site.save
						if session[:usertype]=="publisher"
							User.where("`users`.`id` = '#{session[:user_id]}'").update_all(:userType => "both")
							session[:usertype]="both"
						end
					end
					retarget=Array.new
					retarget={'retargetName'=>'All Visitors','duration'=>"",'retargetType' => 'path','retargetValue' => '/*','siteId'=>@site.id};
					@newretarget=Retarget.new(retarget)
					@newretarget.save
					@site=Site.where(advertiserId: session[:user_id],siteStatus:"active").limit(1).order('id asc')
					@site.each do |sitei|
						session[:site_name] = sitei.siteName
						session[:site_id] = sitei.id
						session[:site_url] = sitei.siteUrl
					end
					
					if flash[:notice] != nil || flash[:notice] != ""
						if session[:return_to] != nil
							session[:return_to] = nil
							redirect_to "/mycampaigns?aft=1"
						else
							redirect_to sites_path
						end
					else
						redirect_to sites_path
					end
			else
				if resp.code[0] != "4" && resp.code != "0"
					@site = Site.new(params[:site])
					if @site.save
						if session[:usertype]=="publisher"
							User.where("`users`.`id` = '#{session[:user_id]}'").update_all(:userType => "both")
							session[:usertype]="both"
						end
					end
					retarget=Array.new
					retarget={'retargetName'=>'All Visitors','duration'=>"",'retargetType' => 'path','retargetValue' => '/*','siteId'=>@site.id , 'advertiserId' => session[:user_id] };
					@newretarget=Retarget.new(retarget)
					@newretarget.save
					@site=Site.where(advertiserId: session[:user_id],siteStatus:"active").limit(1).order('id asc')
					@site.each do |sitei|
					
						session[:site_name] = sitei.siteName
						session[:site_id] = sitei.id
						session[:site_url] = sitei.siteUrl
					end
					@allSites =Site.where(advertiserId: session[:user_id])
					if @allSites.count ==1
						if session[:return_to] != nil
							redirect_to "/mycampaigns?aft=1"
							session[:return_to] = nil
						else
							redirect_to sites_path
						end
					else
						redirect_to sites_path
					end
				else
					flash[:error] = "Url is broken, please give a valid one. Error code #{resp.code} received!"
					redirect_to "/sites/new"
				end
			end
  end
  
  #### Code to create site ends here ####
  
  def show
    @site = Site.find(params[:id])
  end
  
  #### Site tracking tag starts here #### 
  
  def tag
		if session[:site_id] != nil
		  if params[:id] != nil
		    @sitedetails = Site.where(advertiserId: session[:user_id],id: params[:id],siteStatus:"active")
				  if @sitedetails.count != 0
						@sitedetails.each do |sitedetails|
						  @sitename=sitedetails.siteName
						  @siteurl=sitedetails.siteUrl
						  @siteid=sitedetails.id
						end
					else
						flash[:error]="Tag is deactivated!"
						redirect_to "/sites"
					end
		  else
		    @sitename=session[:site_name]
		    @siteurl=session[:site_url]
		    @siteid=session[:site_id]
		  end
		  @sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
		  if(params.key?('email_addresses'))
		    TagMailer.tag_email(params['email_addresses'],params['scriptcode'],params['sitename1'],params['email1']).deliver
		    flash[:notice] = "Code has been delivered to your developers"
		  end
		else
			redirect_to "/users/introduction"
		end
  end
  
  #### Site tracking tag ends here ####
  
  #### Sites display code starts here ####
  
   def index
    #@sites = Site.all
	@sitesList=Site.where(advertiserId: session[:user_id])
	if params[:type].present? && params[:type] != 'all'
		@sitesList=Site.where(advertiserId: session[:user_id],siteStatus:params[:type])
	end
    @sites=Site.where(advertiserId: session[:user_id],siteStatus:"active")
    @Allsites=Site.where(advertiserId: session[:user_id])
    # @sites=Site.where(advertiserId: session[:user_id],siteStatus:"active")
    
    
		if @sites.count == 0 && @Allsites.count >0
			if flash[:notice].present?
				if flash[:notice] != ""
					flash[:notice] = flash[:notice] + " Please re-activate any site."
				end 
			end	
		elsif @sites.count == 0 && @Allsites.count == 0
			redirect_to "/users/introduction"
		end
  end
  
  #### Sites display code ends here #### 
  
  #### Sites edit code here ####
  def edit
		begin
			@site = Site.find(params[:id])
			rescue ActiveRecord::RecordNotFound
			render_404
		else
			if @site.advertiserId.to_i != session[:user_id].to_i
				render_404
			end
			@sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
		end
    # @subjects = Subject.find(:all)
  end
  def update
  		@sites =Site.where(advertiserId: session[:user_id],siteStatus:"active")
  		require 'net/http'
			cusUrl = params[:site][:siteUrl]
			@site = Site.find(params[:id])
			begin
					uri = URI.parse(cusUrl)
			    http = Net::HTTP.new(uri.host, uri.port)
			    if cusUrl =~ /^https/
					  http.use_ssl = true
						http.verify_mode = OpenSSL::SSL::VERIFY_NONE
					end
			    request = Net::HTTP::Get.new(uri.request_uri)
			    #This makes the request
			    resp = http.request(request)
			rescue URI::InvalidURIError => se
					@site = Site.new
					@sites =Site.where(advertiserId: session[:user_id],siteStatus:"active")
					flash[:error] = "Invalid Url"
					redirect_to "/sites/#{params[:id]}/edit"
			rescue SocketError => se
					@site = Site.find(params[:id])
					@sites =Site.where(advertiserId: session[:user_id],siteStatus:"active")
					flash[:error] = "Url is broken, please give a valid one. SocketError received!"
					redirect_to "/sites/#{params[:id]}/edit"
			rescue Errno::ETIMEDOUT => se
						@site = Site.find(params[:id])
						@sites =Site.where(advertiserId: session[:user_id],siteStatus:"active")
						flash[:notice] = "Url is broken, please give a valid one. Request TimedOut!"
						redirect_to "/sites/#{params[:id]}/edit"
			rescue Errno::ECONNREFUSED=>se
						@site = Site.find(params[:id])
						@sites =Site.where(advertiserId: session[:user_id],siteStatus:"active")
						flash[:notice] = "Url is broken, please give a valid one. Server refused the connection!"
						redirect_to "/sites/#{params[:id]}/edit"
			rescue Errno::ECONNRESET => se
				#setSessions(params)
				if @site.update_attributes(params[:site])
					@site=Site.where(advertiserId: session[:user_id]).limit(1).order('id asc')
					@site.each do |sitei|
					  session[:site_name] = sitei.siteName
					  session[:site_id] = sitei.id
					  session[:site_url] = sitei.siteUrl
					end
			  	flash[:notice] = 'Site was successfully updated.'
			  	redirect_to(sites_path)
				else
					render "edit"
				end
			else
				if resp.code[0] != "4" && resp.code != "0"
					if @site.update_attributes(params[:site])
				  @site=Site.where(advertiserId: session[:user_id]).limit(1).order('id asc')
				  @site.each do |sitei|
				    session[:site_name] = sitei.siteName
				    session[:site_id] = sitei.id
				    session[:site_url] = sitei.siteUrl
				  end
				  	flash[:notice] = 'Site was successfully updated.'
				  	redirect_to(sites_path)
					else
						render "edit"
					end
				else
					flash[:error] = "Url is broken, please give a valid one. Error code #{resp.code} received!"
					redirect_to "/sites/#{params[:id]}/edit"
				end
			end
  end
  #### Sites edit code ends here ####
  #### Sites destroy starts here ####
  def destroy
  
    @siteold = Site.find(params[:id])
    @deletedSiteName=@siteold.siteName
	@siteold.destroy
	if params[:id].to_i == session[:site_id].to_i
		@site=Site.where(advertiserId: session[:user_id]).limit(1).order('id asc')
		sitesCount = @site.count
		
		if sitesCount != 0
			@site.each do |sitei|
				session[:site_name] = sitei.siteName
				session[:site_id] = sitei.id
				session[:site_url] = sitei.siteUrl
			end
		else
		    session[:site_name] = nil
		    session[:site_id] = nil
		    session[:site_url] = nil
		end
	end
		flash[:notice]="The site #{@deletedSiteName} has been Deleted!"
    redirect_to '/sites'
  end
  #### Sites destroy code ends here ####
  
  #### Check if url already exists in sites table
  def checkURL
  	if params[:edit].present? && params[:edit]=="edit"
  		@count=Site.where(['siteUrl = ? AND advertiserId = ? AND author_id <> ?', params[:siteurl],session[:user_id], params[:siteId]]).count
  	else
  		 @count=Site.where('siteUrl' =>params[:siteurl] , 'advertiserId'=>session[:user_id]).count
  	end
  if @count == 0
    render text: 0
  else
    render text: 1
  end
  end
  
  def checkSiteName
  	if params[:edit].present? && params[:edit]=="edit"
  		@count=Site.where(['siteName = ? AND advertiserId = ? AND id <> ?', params[:sitename],session[:user_id], params[:siteId]]).count
  	else
  		 @count=Site.where('siteName' =>params[:sitename] , 'advertiserId'=>session[:user_id]).count
  	end
		if @count== 0
		  render text: 0
		else
		  render text: 1
		end
  end
  
  ### change site status
  def changestatus
  	if params[:option] =="activate"
  		@option="active"
  		@msg="Activated"
  	else
  		@option="deactive"
  		@msg="Deactivated"
  	end
  	@status={"siteStatus"=>@option}
  	@site = Site.find(params[:id])
  	@site.update_attributes(@status)
  	@sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
  	if @sites.count==0
  			session[:site_name] = nil
		    session[:site_id] = nil
		    session[:site_url] = nil
		elsif @sites.count==1
  			@sites.each do |sitei|
					session[:site_name] = sitei.siteName
					session[:site_id] = sitei.id
					session[:site_url] = sitei.siteUrl
				end
  	end
		flash[:notice]="The site #{@site.siteName} has been #{@msg}. "
		if @option == "deactive"
			src =  Tagaly3::SRC
			@uri = URI.parse(src)
			http = Net::HTTP.start(@uri.host,@uri.port)
			request = Net::HTTP::Post.new("/adexchange/advertiser/campaign/deactivate/siteId/" + params[:id])
			response = http.request(request)
    	@code = response.code
			if @code == '200'
				if flash[:notice] != ""
					flash[:notice] = flash[:notice] + " Campaigns related to your site are paused. "
				end 
			end
		end
  	
  	redirect_to '/sites/'
  end
end
