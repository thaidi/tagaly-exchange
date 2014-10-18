=begin
  Page that manages the retargets !
  creates retargets , updates retargets , display of the retargets and the segment view of the retargets
=end

class RetargetsController < ApplicationController
  require 'net/http'
  require 'json'
  require 'uri'
  require 'date'
  layout 'advertiser'
  
 
 #### Action to create retarget in campaigns page 
  def frame
    @sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
  end
	
  #### code to create the retargets starts here ####
  def new
  	@count=Retarget.where(['siteId = ? AND retargetName <> ?', session[:site_id], 'All Visitors']).count
    @sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
    if params[:frame] == "frame"
      render 'new' , :layout => false
    end
  end
  
  def create
    #render text: params[:retarget].inspect
    retargets=Array.new
    regtypeval=params[:retarget][:retargeting_type]
    retargetName = params[:retarget][:listname]
    advertiserId = session[:user_id].to_i
    siteId = session[:site_id].to_i
    version = 0
    retargetsWithName = Retarget.where(['siteId = ? AND retargetName = ?', siteId , retargetName])
    retargetsWithName.each do | eachRetarget |
    	if eachRetarget[:version].to_i > version.to_i
    		version = eachRetarget[:version]
    	end
    end
    version = version + 1
    retargets = { 'retargetName' => retargetName , 'duration' => params[:retarget][:duration], 'retargetType' => params[:retarget][:retargeting_type], 'retargetValue' => params[:retarget][regtypeval], 'advertiserId' => advertiserId , 'siteId' => siteId , 'version' => version , 'status' => 'active'}
    @retarget = Retarget.new(retargets)
    @retarget.save
    retargetId=@retarget.id
    if params[:frame] != "frame"
      redirect_to retargets_path
    else 
      redirect_to "/retargets/?frame=frame&retargetId=#{retargetId}"
    end
    
  end
  #### code to create the retargets ends here ####
  def segment
    @sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")

		begin
    	@retarget = Retarget.find(params[:id])
			rescue ActiveRecord::RecordNotFound
			render_404
		else
			if @retarget.siteId != session[:site_id]
				render_404
			else
				@sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
				if session[:startdate]==nil
					@startdate=Date.today - 30
					@enddate=Date.today
				else
					@startdate=session[:startdate]
					@enddate=session[:enddate]
				end
				if session[:user_timezone] != nil
				  @timezone=session[:user_timezone].dup
				else
				  @timezone='UTC'
				end
				@timezone=@timezone.sub! '/', '%2F'
				@siteId=session[:site_id]
    		src = Tagaly3::SRC + "/adexchange/trackAudience/graph/#{@siteId}/#{params[:id]}/#{@timezone}/#{@startdate.to_s+" 00:00:00"}/#{@enddate.to_s+" 23:59:59"}"
				src=URI.encode(src)
				url = URI.parse(src)
				req = Net::HTTP::Get.new(url.to_s)
				res1 = Net::HTTP.start(url.host, url.port) {|http| http.request(req) }
				response=res1.body
				$graphDataForRetarget = JSON.parse(response)
				if session[:user_timezone] != nil
				  session[:user_timezone]=@timezone.sub! '%2F','/'
				end
			end
		end
    #render text:  $graphDataForRetarget
  end  
  
  ### Show action starts here
  def show
    @retarget = Retarget.find(params[:id])
    redirect_to "/retargets"
  end
  
  #### Retargets display method starts here ####
  def index
  ### If the site id is nill then redirect to the sites new page else proceed as usual
 		if session[:site_id] == nil
      		#flash[:notice]="Please create a new site before you proceed !"
      		session[:return_to]="/retargets?aft=1"
      		redirect_to '/sites'
    else
			#### If the action is not used for campaigns then go as usual
			if params[:frame] != "frame"
				if params[:retarget_type]
				 @retargets = Retarget.where(retargetType:params[:retarget_type],siteId: session[:site_id])
				else if params[:search]
				 @retargets = Retarget.where("retargetName LIKE :listname1 AND siteId = :siteId1",
				 {:listname1 => "%#{params[:search]}%", :siteId1 => session[:site_id]})
				   else
				  		@retargets = Retarget.where(siteId: session[:site_id])
				   end
				end
				
				@sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")

				#### Code to call the API for graph starts here ####
		
				  Date.strptime(DateTime.now.to_s).strftime("%m/%d/%Y")
				  now = Time.now.in_time_zone(session[:user_timezone])
				  to_date=Time.strptime(now.to_s,"%Y-%m-%d %H:%M:%S %Z").strftime("%Y-%m-%d %H:%M:%S")
					days_ago = (now - (30*24*60*60))
					from_date=Time.strptime(days_ago.to_s,"%Y-%m-%d %H:%M:%S %Z").strftime("%Y-%m-%d %H:%M:%S")
					#@variable ||= "Thu Dec 19 2013,Fri Dec 20 2013,Sat Dec 21 2013"

					#### Get the current host
				if session[:user_timezone] != nil
				  @timezone=session[:user_timezone].dup
				 else
				  @timezone='UTC'
				 end
				 #@timezone=@timezone.strip
				 @timezone=@timezone.sub! '/', '%2F'
					src=Tagaly3::SRC + "/adexchange/graph/site/#{session[:site_id]}/#{session[:startdate].to_s+" 00:00:00"}/#{session[:enddate].to_s+" 23:59:59"}/#{@timezone}"
					if session[:user_timezone] != nil
				    session[:user_timezone]=@timezone.sub! '%2F','/'
				  end
					src=URI.encode(src)
					url = URI.parse(src)
					req = Net::HTTP::Get.new(url.to_s)
					res1 = Net::HTTP.start(url.host, url.port) {|http|
						http.request(req)
						}
					resp1=res1.body
					respcode1=res1.code
					parsed1 = JSON.parse(resp1) 
					@count_y=Array.new
					@variable='';
					parsed1.each do |p|
						@count_y.push(p['count'].to_i)
						@variable = @variable + p['date'] + ","
					end
					@variable=@variable.chomp(',')
					#render text: src
					#### Code to call the API for graph ends here ####
					#count_y=''
			else
			### Else Render the frame page
				 @retargetDetail = Retarget.find(params[:retargetId])
				 #render text: @retargetDetail.inspect
				render "frame" , :layout => false , :collection => @retargetDetail, :as => :retargetDetail
			end
		end ### end else
  end
  
  #### Retargets display method ends here ####
  
  #### Retargets edit methods starts here ####
  def edit
		begin
    	$retargetDetails =@retarget = Retarget.find(params[:id])
			rescue ActiveRecord::RecordNotFound
			render_404
		else
			if @retarget.siteId != session[:site_id] || (@retarget.retargetName == "All Visitors" && @retarget.duration == nil )
				render_404
			end
			@sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
		end
    # @subjects = Subject.find(:all)
  end
  def update
  	@count=Retarget.where(['siteId = ? AND retargetName <> ?', session[:site_id], 'All Visitors']).count
  	@retargetDetails = Retarget.find(params[:id])
  	@newRetarget="no"
  	retargets=Array.new
		regtypeval = params[:retarget][:retargetType]
		retargetName = params[:retarget][:listname]
		siteId = session[:site_id]
		if @retargetDetails.retargetName == retargetName
			if @retargetDetails.retargetType == params[:retarget][:retargetType] && $retargetDetails.retargetValue==params[:retarget][regtypeval]
				@newRetarget = "no"
			else
				@newRetarget = "yes"
			end
  	else
			@newRetarget = "yes"
  	end
  	
    version = 0
    retargetsWithName = Retarget.where(['siteId = ? AND retargetName = ?', siteId , retargetName])
    retargetsWithName.each do | eachRetarget |
    	if eachRetarget[:version].to_i > version.to_i
    		version = eachRetarget[:version]
    	end
    end
    version = version + 1
    
  	if @newRetarget == "no"
				retargets = { 'retargetName' => retargetName , 'duration' => params[:retarget][:duration], 'retargetType' => params[:retarget][:retargetType], 'retargetValue' => params[:retarget][regtypeval], 'advertiserId' => params[:retarget][:advertiseris] }
				@retarget = Retarget.find(params[:id])
				if @retarget.update_attributes(retargets)
				  flash[:notice] = 'Retarget was successfully updated.'
				  redirect_to(retargets_path)
				else
					render "edit"
		  	end
		else
				  
				retargetname = params[:retarget][:listname]
			 	retargets = Array.new
				regtypeval = params[:retarget][:retargetType]

				retargets = {'retargetName' => retargetname , 'version' => version ,'duration' => params[:retarget][:duration] , 'retargetType' => params[:retarget][:retargetType], 'retargetValue' => params[:retarget][regtypeval], 'advertiserId' => session[:user_id] , 'siteId' => session[:site_id].to_i , 'status' => 'active'}
				@retarget = Retarget.new(retargets)
				
				### Create new retarget
				@retarget.save
				retargetId = @retarget.id
				
				### Assign the new retarget created to the campaign if any
				@siteId=session[:site_id]
				src =  Tagaly3::SRC
				@uri = URI.parse(src)
				http = Net::HTTP.start(@uri.host,@uri.port)
				request = Net::HTTP::Get.new("/adexchange/advertiser/campaign/list/#{@siteId}")
				response = http.request(request)
				@campaigns=JSON.parse(response.body)
				@campaigns.each do |key,camp|
					@retargetids=camp["retargeting"].to_s
					if @retargetids.include?("#{params[:id]}")
						@campaignId=key
						@newlist=camp["retargeting"].join(",")
						@retargetids=@newlist.gsub("#{params[:id]}","#{retargetId}")
						http = Net::HTTP.start(@uri.host,@uri.port)
						request = Net::HTTP::Post.new("/adexchange/advertiser/campaign/#{@campaignId}")
						request.set_form_data({"retargeting"=>@retargetids})
						### Get Response
						response = http.request(request)
						@code = response.code
						http.finish
					end
				end
				
				### Destroy the old retarget
				### @retarget = Retarget.find(params[:id])
				if @retargetDetails.update_attributes({'status' => 'delete' })
					logger.debug "Deleted retarget"
				else
					logger.debug "Not Deleted"
				end
				
    		### Set flash message
				flash[:notice] = "Your old retarget named \"#{@retargetDetails.retargetName}\" has been deleted and a new retarget named \"#{retargetname}\" has been created !"
				redirect_to retargets_path
		 end
  end
  #### Retargets edit methods ends here ####
  #### Retargets destroy method starts here ####
  def destroy
    @retarget = Retarget.find(params[:id])
		if @retarget.update_attributes({'status' => 'delete' })
			logger.debug "Deleted retarget"
		else
			logger.debug "Not Deleted"
		end
    #@retarget.destroy
    redirect_to retargets_path
  end
  #### Retargets destroy method ends here ####
  
  #### method to check the retarget list name availability starts here ####
  def checklistnameavl
    if Retarget.where(retargetName: params[:q],siteId: session[:site_id]).count == 0
      render :text => "OK"
    else
      render :text => "NO"
    end
  end
  #### method to check the retarget list name availability starts here ####
  
  def segmentgraph
  	@sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
  	@cnt=0
    
       @count_y=Array.new
				@variable='';
				$graphDataForRetarget.each do |arr|
					arr.each do |key,val|
						if params[:type]=="perday"
							@count_y.push(val.to_i)
						else
							@cnt=@cnt+val.to_i
							@count_y.push(@cnt.to_i)
				  	end
						@variable = @variable + key.to_s + ","
					end
				end
				@variable=@variable.chomp(',')
				render :layout => false
				#render text: $graphDataForRetarget
    end

  
end
