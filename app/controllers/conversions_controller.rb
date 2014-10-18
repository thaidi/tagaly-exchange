=begin
  Controller for conversions 
=end
class ConversionsController < ApplicationController
	layout 'advertiser'
	require 'net/http'
	include CheckSiteIdHelper
  def frame
    @sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
  end
  #### Conversions display code starts here ####
  def index
	  src =  Tagaly3::SRC
	  @HOST_NAME = Tagaly3::HOST_NAME
	  @siteId=session[:site_id]
	  @host = Socket.gethostname
	  @uri = URI.parse(src)
		if params[:status].present?
			@status = status = params[:status]
		else
			@status = status = "All"
		end
		if @status == "All" || @status == "Assigned" || @status == "NonAssigned"
			### If the site id is nill then redirect to the sites new page else proceed as usual
	 		if session[:site_id] == nil
				#flash[:notice]="Please create a new site before you proceed !"
				session[:return_to]=request.fullpath + "?aft=1"
				redirect_to '/sites'
		  else
				@sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
				@usrtimeZone = Rack::Utils.escape(session[:user_timezone])
				#### If page is not used for the campaigns page proceed as usual
				if params[:frame] != "frame"
				#### Call API to get the conversions list
					http = Net::HTTP.new(@uri.host,@uri.port)
					request = Net::HTTP::Get.new("/adexchange/advertiser/conversion/dashboard/siteId/#{@siteId}/All/#{@usrtimeZone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}/name/0/10")
					response = http.request(request)
					begin
	@bing = "/adexchange/advertiser/conversion/dashboard/siteId/#{@siteId}/#{@status}/#{@usrtimeZone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}/name/0/10"
						@totalConversions = JSON.parse(response.body)
						if @totalConversions.present?
							http = Net::HTTP.new(@uri.host,@uri.port)
							request = Net::HTTP::Get.new("/adexchange/advertiser/conversion/dashboard/siteId/#{@siteId}/#{@status}/#{@usrtimeZone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}/name/0/10")
							response = http.request(request)
							@ConversionsData = JSON.parse(response.body)
							@ConversionsDataStats = @ConversionsData["stats"]
							@ConversionsDataTotals = @ConversionsData["totals"]
						else
							if params[:aft]=='1'
								redirect_to "/conversions/startConversion?aft=1"
							else
								redirect_to "/conversions/startConversion"
							end
						end
					rescue Errno::ECONNREFUSED
						@failure =""
					rescue JSON::ParserError
						@failure =""
					else
						@success =""
					end
=begin
						@siteId=session[:site_id]
						request = Net::HTTP::Get.new("/adexchange/advertiser/conversion/list/#{@siteId}")
						response = http.request(request)
						@code = response.code
						@conversionsList = JSON.parse(response.body)
=end
					else
					#### Execute the campaigns page conversion
						src =  Tagaly3::SRC
						@HOST_NAME = Tagaly3::HOST_NAME
						@host = Socket.gethostname
						@uri = URI.parse(src)
						http = Net::HTTP.new(@uri.host,@uri.port)
						request = Net::HTTP::Get.new("/adexchange/advertiser/conversion/#{params[:conversionId]}")
						### Get Response
						response = http.request(request)
						@code = response.code
						@conversionDetails=JSON.parse(response.body)
						render "frame" , :layout => false , :collection => @conversionDetails, :as => :conversionDetails
					end
			end ### End of the else condition
		else
			render_404
		end
  end
  #### Conversions display code ends here ####
  
  #### New conversion goal creation code starts here ####
  def new
    @sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
	src =  Tagaly3::SRC
	@HOST_NAME = Tagaly3::HOST_NAME
	@siteId=session[:site_id]
	@host = Socket.gethostname
	@uri = URI.parse(src)
	http = Net::HTTP.new(@uri.host,@uri.port)
	request = Net::HTTP::Get.new("/adexchange/advertiser/conversion/list/#{@siteId}")
	response = http.request(request)
	@code = response.code
	@conversionsList = JSON.parse(response.body)
	@count=@conversionsList.count
    #### If action is used for campaigns page then render the frame view
    if params[:frame] == "frame"
	render 'new' , :layout => false
    end
  end
  def checklistnameavl
	src =  Tagaly3::SRC
	@HOST_NAME = Tagaly3::HOST_NAME
	@siteId=session[:site_id]
	@host = Socket.gethostname
	@uri = URI.parse(src)
	convname=params[:q]
	http = Net::HTTP.new(@uri.host,@uri.port)
	request = Net::HTTP::Get.new("/adexchange/advertiser/conversion/list/#{@siteId}")
	response = http.request(request)
	@code = response.code
	@conversionsList = JSON.parse(response.body)
	contains="no"
	@conversionsList.each do |key,conv|
		if conv["conversionName"] == convname
      	 	contains="yes"
      	end
    end
	if contains=="yes"
		render :text => "NO"
	else
		render :text => "OK"
	end

  end
  def create
    conversions=Array.new
    contypeval=params[:conversion][:conversionType]
    conversions = {'conversionName' => params[:conversion][:conversionName], 'conversionType' => params[:conversion][:conversionType], 'conversionTypeValue' => params[:conversion][contypeval], 'conversionValue' => params[:conversion][:revenue].to_f, 'conversionCounting' => params[:conversion][:conversionCounting], 'siteId' => params[:conversion][:siteid],'advertiserId' => params[:conversion][:advertiserId]}
    
    ####Conversions API call starts here
    
    src =  Tagaly3::SRC
    @HOST_NAME = Tagaly3::HOST_NAME
    @host = Socket.gethostname
    @uri = URI.parse(src)
        
    http = Net::HTTP.new(@uri.host,@uri.port)
    request = Net::HTTP::Put.new("/adexchange/advertiser/conversion")
    request.set_form_data({"conversionName"=>params[:conversion][:conversionName].to_s , "conversionType"=> params[:conversion][:conversionType].to_s , "conversionTypeValue" => params[:conversion][contypeval].to_s , "conversionValue" => params[:conversion][:revenue].to_f ,"conversionCounting" => params[:conversion][:conversionCounting], "advertiserId"=>params[:conversion][:advertiserId].to_i , "siteId"=>params[:conversion][:siteid].to_i })
    ### Get Response
    response = http.request(request)
    @code = response.code
    if @code=='200'
      flash[:notice]="Conversion goal created successfully !"
    else
      flash[:error]="Some problem occured while conversion goal creation ! Please contact the administrator ."
    end
    if params[:frame] != "frame"
      redirect_to conversions_path
    else 
      redirect_to "/conversions/?frame=frame&conversionId=#{response.body}"
    end
    
  end
  
  #### New conversion goal creation code ends here ####
  
  def startConversion
		@sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
		if @sites.count == 0
			redirect_to "/users/introduction"
		end
	end
  
  ####  conversion goal edit code starts here ####
  def edit
      #@conversion = Conversion.find(params[:id])
       @sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
       #### Call API to get the conversions list
      src =  Tagaly3::SRC
      @HOST_NAME = Tagaly3::HOST_NAME
      @siteId=session[:site_id]
      @host = Socket.gethostname
      @uri = URI.parse(src)
      http = Net::HTTP.new(@uri.host,@uri.port)
      request = Net::HTTP::Get.new("/adexchange/advertiser/conversion/#{params[:id]}")
      response = http.request(request)
      @code = response.code
      @conversionDetails = JSON.parse(response.body)
      $conversionDetails=@conversionDetails
      if @conversionDetails['conversionName']==nil
				  redirect_to root_url
      end
			@returnValue = checkSiteId(@conversionDetails,'advertiser')
			if @returnValue == false
				render_404
			end
      ### Update conversion starts here
      
      if params[:conversion]
		      request = Net::HTTP::Post.new("/adexchange/advertiser/conversion/#{params[:id]}")
		      request.set_form_data({"conversionName"=>params[:conversion][:conversionName].to_s , "conversionValue" => params[:conversion][:revenue].to_f })
		      response = http.request(request)
		      @code = response.code
					redirect_to conversions_path
        #### Update conversion ends here
        
      end
  end
  #### conversion goal edit code ends here ####

  #### conversion goal destroy code starts here ####
  def destroy
    src =  Tagaly3::SRC
    @HOST_NAME = Tagaly3::HOST_NAME
    @host = Socket.gethostname
    @uri = URI.parse(src)
    ### Call Delete API to delete the conversion  
    http = Net::HTTP.new(@uri.host,@uri.port)
    request = Net::HTTP::Delete.new("/adexchange/advertiser/conversion/#{params[:id]}")
    ### Get Response
    response = http.request(request)
    @code = response.code
    if @code=='200'
      flash[:notice]="Conversion goal deleted successfully !"
    else
      flash[:error]="Some problem occured while conversion goal deletion ! Please contact the administrator ."
    end
    redirect_to conversions_path
  end
  #### conversion goal destroy code ends here ####
end
