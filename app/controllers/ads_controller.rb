=begin
  Advertiment controller

    def updatestatus
      @sites = Site.where(advertiserId: session[:user_id])
      id = params[:adid]
      src =  Tagaly3::SRC
      @uri = URI.parse(src)
      http = Net::HTTP.start(@uri.host,@uri.port)
      request = Net::HTTP::Post.new("/adexchange/advertiser/advertisement/#{id}")
      request.set_form_data({"adStatus"=>"Deleted"})
      response = http.request(request)
    	http.finish
  end
=end
class AdsController < ApplicationController
  layout 'advertiser'
	require 'net/http'
	include CheckSiteIdHelper
	include AdsHelper
  #### Advertiment display code starts here ####
	def frame
    @sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
	end
	def show
    @sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
	end
  def index
		if session[:site_id].present?
			if params[:frame] != "frame" 
				@sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
				@host = Socket.gethostname
				userId = session[:user_id]
				siteId = session[:site_id]
				usrtimeZone = Rack::Utils.escape(session[:user_timezone])
				todaydate = Date.today
				src =  Tagaly3::SRC
				# Code to connect to API to get data of all th adunits add by current user.
				@uri = URI.parse(src)
				http = Net::HTTP.start(@uri.host,@uri.port)
				request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/dashboard/siteId/#{siteId}/assignedStatus/All/ActiveOrPaused/#{usrtimeZone}/2010-01-01%2000:00:00/#{todaydate}%2023:59:59/all/0/10")
				response = http.request(request)
				@adsData = JSON.parse(response.body)
				#render text: @adsData
				if @adsData["stats"].present?
				else
					if params[:aft]=='1'
						redirect_to "/ads/startAd?aft=1"
					else
						redirect_to "/ads/startAd"
					end
				end
				http.finish
			else
					src =  Tagaly3::SRC
		  		  @HOST_NAME = Tagaly3::HOST_NAME
		  	          @host = Socket.gethostname
		  	          @uri = URI.parse(src)
		  		  http = Net::HTTP.new(@uri.host,@uri.port)
		  		  request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/#{params[:adId]}")
		  		  ### Get Response
		  		  response = http.request(request)
		  		  @code = response.code
		  		  @adDetails=JSON.parse(response.body)
				render "frame" , :layout => false , :collection => @adDetails, :as => :adDetails
			end
		else
		  #flash[:notice] = "Please add your site details before creating an ad."
		  session[:return_to]="/ads/?adtype=all&aft=1"
		  redirect_to '/sites'
		end
		# my_logger.info("Creating user with name #{}")
  end
	def my_logger
    @@my_logger ||= Logger.new("#{Rails.root}/log/my.log")
  end
  #### Advertiment display code ends here ####

  #### Advertiment creations starts here ####
  def new

		if session[:user_id] == '' || session[:user_id] == nil
		  redirect_to '/login'
		else
		#Gets all sites for a particular users 
    @sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
		#Gets all banner sizes for validations
    @bannersizes = Bannersizes.find(:all)
		src =  Tagaly3::SRC
		@uri = URI.parse(src)
		http = Net::HTTP.new(@uri.host,@uri.port)
		request = Net::HTTP::Get.new("/adexchange/publisher/adUnit/adUnitSize")
		response = http.request(request)
		#Gets all adunit sizes that are there for a native adunits
		@adunitSizes=JSON.parse(response.body)
		
		#### Get campaigns list for the minimum bid strategy suggestion
		@siteId=session[:site_id]
		src =  Tagaly3::SRC
		@uri = URI.parse(src)
		http = Net::HTTP.start(@uri.host,@uri.port)
		request = Net::HTTP::Get.new("/adexchange/advertiser/campaign/list/#{@siteId}")
		response = http.request(request)
		@campaigns=JSON.parse(response.body)
      
		@userId = session[:user_id]
		request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/list/#{@userId}")
		response = http.request(request)
		@allAds=JSON.parse(response.body)
      #render text: @campaigns
		if session[:site_id].present?
			if params[:frame] == "frame"
				render 'new' , :layout => false
			end
		else
		  flash[:notice] = "Please add your site details before creating an ad."
		  session[:return_to]="/ads/?adtype=all"
		  redirect_to '/publishersites/new'
		end
  end
	end

  def edit	

		if session[:user_id] == '' || session[:user_id] == nil
		  redirect_to '/login'
		else
  #### Get campaigns list for the minimum bid strategy suggestion
  @sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
		@siteId=session[:site_id]
		src =  Tagaly3::SRC
      @uri = URI.parse(src)
      http = Net::HTTP.start(@uri.host,@uri.port)
		request = Net::HTTP::Get.new("/adexchange/advertiser/campaign/list/#{@siteId}")
      response = http.request(request)
      @campaigns=JSON.parse(response.body)

		@userId = session[:user_id]
		request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/list/#{@userId}")
		response = http.request(request)
		@allAds=JSON.parse(response.body)

    @host = Socket.gethostname
    @bannersizes = Bannersizes.find(:all)
    
    src =  Tagaly3::SRC
    if params[:ad]
      # display_url
      # Code to connect with API

    ctime=Time.now().to_i
    filename = ''
    if params[:upload]
      if params[:ad][:changeImage] == "Old"
         filename = params[:ad][:filename]
      else
         filename = ctime.to_s + params[:upload]['datafile'].original_filename
         post = DataFile.save(params[:upload],ctime)
      end
		else
      if params[:ad][:changeImage] == "Old"
         filename = params[:ad][:filename]
			end
    end
=begin
		if params[:ad][:pricing_val] == "CPC"
			bidType = "CPC"
			volume = params[:cpc_firstUnit]
			price = params[:cpc_secondUnit]
		elsif params[:ad][:pricing_val] == "CPM"
			bidType = "CPM"
			volume = params[:cpm_firstUnit]
			price = params[:cpm_secondUnit]
		elsif params[:ad][:pricing_val] == "CPA"
			bidType = "CPA"
			volume = params[:cpa_firstUnit]
			price = params[:cpa_secondUnit]
		end
=end
	
		
		id = params[:id]
		### check if new ad to be created or not
		newad="no"
		if params[:ad][:ad_type]=="TextAd"
		### removed to comment bid strategy
		#|| params[:ad][:device_preferences] != $adDetails["devicePreference"]
			if params[:ad][:destination_url] != $adDetails["adDestinationUrl"] || params[:ad][:display_url] != $adDetails["adDisplayUrl"] || params[:ad][:headline] != $adDetails["adHeadline"] || params[:ad][:text] != $adDetails["adText"] 
				newad="yes"
			end
			
		elsif params[:ad][:ad_type]=="BannerAd"
		#### removed to comment bid strategy
		#params[:ad][:device_preferences] != $adDetails["devicePreference"]
			if params[:ad][:destination_url] != $adDetails["adDestinationUrl"] || $adDetails["adImageUrl"] != filename
				newad="yes"
			end
		
		end
		
			if newad=="yes"
				#### adding new ad starts here
					src =  Tagaly3::SRC
		  		@HOST_NAME = Tagaly3::HOST_NAME
		  		@host = Socket.gethostname
				  @uri = URI.parse(src)

				  http = Net::HTTP.start(@uri.host,@uri.port)
				  request = Net::HTTP::Post.new("/adexchange/advertiser/advertisement/#{id}")
				  request.set_form_data({"adStatus"=>"Deleted"})
				  response = http.request(request)
			 		http.finish
			 		#### Change ad name
			 		if params[:ad][:ad_name] == $adDetails["adName"]
				 		toadd = params[:ad][:ad_name].split('_').last.to_i
				 		if toadd != 0 && params[:ad][:ad_name].count('_')!=0
				 			toadd=toadd + 1
				 			pos=params[:ad][:ad_name].rindex("_")
				 			adname = params[:ad][:ad_name][0,pos].to_s + "_" + toadd.to_s
				 		else
				 			adname=params[:ad][:ad_name].to_s+"_1"
				 		end
				 		returnvar=checkAdName "#{adname}"
				 		until returnvar == "no" do
				 		#render text: "entered"
				 			toadd = adname.split('_').last.to_i
					 		if toadd != 0
					 			toadd=toadd + 1
					 			pos=adname.rindex("_")
					 			adname = adname[0,pos].to_s + "_" + toadd.to_s
					 		else
					 			adname=adname.to_s+"_1"
					 		end
					 		returnvar=checkAdName "#{adname}"
				 		end
			 		else
			 			adname=params[:ad][:ad_name].to_s
			 		end
			 		
			 		adname=params[:ad][:ad_name].to_s
			 		#### Removed to comment bid strategy
			 		# "price"=> price,"devicePreference"=>params[:ad][:device_preferences]"bidType"=> bidType , "volume"=> volume ,
			 		@toadDetails={"advertiserId" => session[:user_id], "siteId" => session[:site_id],
				  "adType" => params[:ad][:ad_type] ,"adName" => adname,
				  "adDestinationUrl"=>params[:ad][:destination_url], "adDisplayUrl"=> params[:ad][:display_url],"adStatus"=>"Active",
				  "adSize"=>params[:ad][:bannerImageSize], "adHeadline"=> params[:ad][:headline], "adDescription"=> "", "adText"=> params[:ad][:text],
				  "utmParameters"=> "", "adImageUrl"=> filename , "version"=> "1.0".to_f }
				  adId=copyAd("#{params[:id]}","2.0",@toadDetails)
				
				### Assign new ad to the campaign
				
				#### Get the campaign id and assign the latest ad 
				@campaigns.each do |key,camp|
					@adids=camp["adId"].to_s
					if @adids.include?("#{params[:id]}")
						@campaignId=key
						@newlist=camp["adId"].join(",")
						@ads=@newlist.gsub("#{params[:id]}","#{adId}")
						http = Net::HTTP.start(@uri.host,@uri.port)
						request = Net::HTTP::Post.new("/adexchange/advertiser/campaign/#{@campaignId}")
						request.set_form_data({"adId"=>@ads})
						### Get Response
						response = http.request(request)
						@code = response.code
						http.finish
					end
				end
				if adId != '200'
        	flash[:notice] = "Your previous Ad with name \"#{$adDetails['adName']}\" has been deleted and a new Ad with name \"#{adname}\" has been created."
        	redirect_to '/ads/?adtype=all'
		    else
		      flash[:notice] = "Some error occured!Please try again"
		      redirect_to '/ads/#{id}/edit' 
		    end
		    
		    #### adding new ad ends here
		else
		
					src =  Tagaly3::SRC
		  		@HOST_NAME = Tagaly3::HOST_NAME
		  		@host = Socket.gethostname
				  @uri = URI.parse(src)
				  http = Net::HTTP.start(@uri.host,@uri.port)
				  request = Net::HTTP::Post.new("/adexchange/advertiser/advertisement/#{id}")
				  #### Removed to comment bid strategy
				  #"bidType"=> bidType , "volume"=> volume , "price"=> price
					request.set_form_data({"advertiserId" => session[:user_id], "siteId" => session[:site_id],
				  "adType" => params[:ad][:ad_type] ,"adName" => params[:ad][:ad_name],
				  "adDestinationUrl"=>params[:ad][:destination_url], "adDisplayUrl"=> params[:ad][:display_url],"adStatus"=>"Active",
				  "adSize"=>params[:ad][:bannerImageSize], "adHeadline"=> params[:ad][:headline], "adDescription"=> "", "adText"=> params[:ad][:text],
				  "utmParameters"=> "", "adImageUrl"=> filename })

				  response = http.request(request)
				  code = response.code
				  #  redirect_to '/ads/?adtype=all'
				  
				http.finish
				adId=id
				if code == '200'
        	flash[:notice] = "You have Updated an Ad."
        	redirect_to '/ads/?adtype=all'
		    else
		      flash[:notice] = "Some error occured!Please try again"
		      redirect_to '/ads/#{id}/edit' 
		    end
		end
		
		#if params[:ad][:campaignid] != nil && params[:ad][:campaignid] != ""
			#adids=params[:ad][:existingadids].to_s + "," + adId.to_s
			#src =  Tagaly3::SRC
		  #@HOST_NAME = Tagaly3::HOST_NAME
		  #@host = Socket.gethostname
		  #@uri = URI.parse(src)
		  #http = Net::HTTP.new(@uri.host,@uri.port)
		  #request = Net::HTTP::Post.new("/adexchange/advertiser/campaign/#{params[:ad][:campaignid]}")
		  #request.set_form_data({"adId"=>adids})
		  ### Get Response
		 # response = http.request(request)
		  #@code = response.code
		#end
    else
      # To get data of selected 'Ad id'
      @id = id = params[:id]
      # Code to connect with API
      @uri = URI.parse(src)
      http = Net::HTTP.start(@uri.host,@uri.port)
      request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/#{id}")
      response = http.request(request)
      @parsed = JSON.parse(response.body)
      $adDetails=@parsed
			@returnValue = checkSiteId($adDetails,'advertiser')
			if @returnValue == false
				render_404
			end
    http.finish
      # '@parsed' holds data of selected 'style id'
    end
  end
	end
  def imagepreference
  render :layout => false 
  
  end
  def create
    @sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
	require 'net/http'
	@HOST_NAME = Tagaly3::HOST_NAME
  	@host = Socket.gethostname
    userId = session[:user_id]
    src =  Tagaly3::SRC
    ads=Array.new
    ctime=Time.now().to_i
    filename = ''
    if params[:upload]
      filename=ctime.to_s + params[:upload]['datafile'].original_filename
      post = DataFile.save(params[:upload],ctime)
    end
    #### bid strategy included
=begin
	if params[:ad][:pricing_val] == "CPC"
	  bidType = "CPC"
	  volume = params[:cpc_firstUnit]
	  price = params[:cpc_secondUnit]
	elsif params[:ad][:pricing_val] == "CPM"
	  bidType = "CPM"
	  volume = params[:cpm_firstUnit]
	  price = params[:cpm_secondUnit]
	elsif params[:ad][:pricing_val] == "CPA"
	  bidType = "CPA"
	  volume = params[:cpa_firstUnit]
	  price = params[:cpa_secondUnit]
	end
=end
#### Request with bid strategy included
=begin
	{"advertiserId" => params[:ad][:userid], "siteId" => session[:site_id],
      "adType" => params[:ad][:ad_type] ,"adName" => params[:ad][:ad_name],
      "adDestinationUrl"=>params[:ad][:destination_url], "adDisplayUrl"=> params[:ad][:display_url],"adStatus"=>"Active",
      "adSize"=>params[:ad][:bannerImageSize], "adHeadline"=> params[:ad][:headline], "adDescription"=> "", "adText"=> params[:ad][:text],
      "utmParameters"=> "", "adImageUrl"=> filename , "bidType"=> bidType , "volume"=> volume , "price"=> price,"version"=> "1.0".to_f,"devicePreference"=>params[:ad][:device_preferences] }
=end
      params[:ad][:userid] = session[:user_id]
      # Code to connect to API to add ad from the form data 
      @uri = URI.parse(src)
      http = Net::HTTP.start(@uri.host,@uri.port)
      request = Net::HTTP::Put.new("/adexchange/advertiser/advertisement")
      request.set_form_data({"advertiserId" => params[:ad][:userid], "siteId" => session[:site_id],
      "adType" => params[:ad][:ad_type] ,"adName" => params[:ad][:ad_name],
      "adDestinationUrl"=>params[:ad][:destination_url], "adDisplayUrl"=> params[:ad][:display_url],"adStatus"=>"Active",
      "adSize"=>params[:ad][:bannerImageSize], "adHeadline"=> params[:ad][:headline], "adDescription"=> "", "adText"=> params[:ad][:text],
      "utmParameters"=> "", "adImageUrl"=> filename ,"version"=> "1.0".to_f })
      response = http.request(request)
    http.finish
		adId=response.body
		
		if params[:ad][:campaignid] != nil && params[:ad][:campaignid] != ""
			adids=params[:ad][:existingadids].to_s + "," + adId.to_s
			src =  Tagaly3::SRC
		  @HOST_NAME = Tagaly3::HOST_NAME
		  @host = Socket.gethostname
		  @uri = URI.parse(src)
		  http = Net::HTTP.new(@uri.host,@uri.port)
		  request = Net::HTTP::Post.new("/adexchange/advertiser/campaign/#{params[:ad][:campaignid]}")
		  request.set_form_data({"adId"=>adids})
		  ### Get Response
		  response = http.request(request)
		  @code = response.code
		end
    #render text: ads
   # @ad = Ad.new(ads)
    #@ad.save
    if params[:frame] != "frame"
      redirect_to "/ads/?adtype=all"
    else 
      redirect_to "/ads/?adtype=all&frame=frame&adId=#{response.body}" ,:layout=>nil
    end
  end
  
  # To delete the style.
  def destroy
    id = params[:id]
    src =  Tagaly3::SRC
    # Code to connect with API
    @uri = URI.parse(src)
    http = Net::HTTP.start(@uri.host,@uri.port)
    request = Net::HTTP::Delete.new("/adexchange/advertiser/advertisement/#{id}")
    response = http.request(request)
    http.finish
    redirect_to '/ads/'
  end
  #### Advertiment creation ends here ####
  
  def updatestatus
  
	
	#render text: 
  	@sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
	
	### Update starts here
    src =  Tagaly3::SRC
    @HOST_NAME = Tagaly3::HOST_NAME
    @host = Socket.gethostname
    @uri = URI.parse(src)
    http = Net::HTTP.new(@uri.host,@uri.port)
    request = Net::HTTP::Post.new("/adexchange/advertiser/advertisement/#{params[:adid]}")
    request.set_form_data({"adStatus"=>params[:status]})
    ### Get Response
    response = http.request(request)
    @code = response.code
	@siteId=session[:site_id]
	### Get all ads inoder to pause the campaign
	
	src =  Tagaly3::SRC
    @HOST_NAME = Tagaly3::HOST_NAME
    @host = Socket.gethostname
    @uri = URI.parse(src)
    http = Net::HTTP.new(@uri.host,@uri.port)

	@userId=session[:user_id]
    request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/list/#{@userId}")
    ### Get Response
    response = http.request(request)
    @AdData = JSON.parse(response.body)
	
	### Get campaign list
	@pausearray = ""
			@pausearray=["Paused"]

	  
		### set campaign status to pause when the ad gets paused
		@campaignId=""
		if params[:campaignid].present?
			@campaignId=params[:campaignid]
		else
			@siteId=session[:site_id]
			src =  Tagaly3::SRC
			@HOST_NAME = Tagaly3::HOST_NAME
			@host = Socket.gethostname
			@uri = URI.parse(src)
			http = Net::HTTP.start(@uri.host,@uri.port)
			request = Net::HTTP::Get.new("/adexchange/advertiser/campaign/list/#{@siteId}")
			request.set_form_data({"adId"=>@ads})
			### Get Response
			response = http.request(request)
			@campaigns = JSON.parse(response.body)
			http.finish
			@campaignId=""
			@campaigns.each do |key,camp|
				@adids=camp["adId"].to_s
				if @adids.include?("#{params[:adid]}")
					@campaignId=key
					camp["adId"].each do |adid|
						if @AdData["#{adid}"]['adStatus'] == "Paused"
							@pausearray=@pausearray.push("Paused")
						else
							@pausearray.push("other")
						end
					end
				end
			end
		end
		if params[:status]=="Paused" && @pausearray.count("Paused") == @pausearray.size
			src =  Tagaly3::SRC
			@HOST_NAME = Tagaly3::HOST_NAME
			@host = Socket.gethostname
			@uri = URI.parse(src)
			http = Net::HTTP.new(@uri.host,@uri.port)
			request = Net::HTTP::Post.new("/adexchange/advertiser/campaign/#{@campaignId}")
			request.set_form_data({"campaignStatus"=>"pause"})
			### Get Response
			response = http.request(request)
			@code = response.code
		end

	
		render text: "success"
     #Campaign.where("`campaigns`.`id` = '#{params[:campaignid]}'").update_all(:cam_status => params[:status])
     
  end
  def startAd
		@sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
		if @sites.count == 0
			redirect_to "/users/introduction"
		end
  end
  
  def getminimumbidprice
  	src =  Tagaly3::SRC
    @HOST_NAME = Tagaly3::HOST_NAME
    @host = Socket.gethostname
    @uri = URI.parse(src)
    http = Net::HTTP.new(@uri.host,@uri.port)


    request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/minBid?campaignId=#{params[:campaignId]}&bidType=#{params[:bidType]}&adType=#{params[:adType]}&adSize=#{params[:adSize]}")
    ### Get Response
    response = http.request(request)
    render text: response.body
  end
  
  ### checkAdName
  def checkAdName(name="")
  	@userId=session[:user_id]
  	if params[:adName].present?
  		adName=params[:adName]
  	else
  		adName=name
  	end
  	src =  Tagaly3::SRC
    @HOST_NAME = Tagaly3::HOST_NAME
    @host = Socket.gethostname
    @uri = URI.parse(src)
    http = Net::HTTP.new(@uri.host,@uri.port)


    request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/list/#{@userId}")
    ### Get Response
    response = http.request(request)
  	begin
      @AdData = JSON.parse(response.body)
      end
      #render text: response.body
      contains="no"
      	@AdData.each do |key,ad|
      	 if ad["adName"]==adName
      	 	contains="yes"
      		end
      	end
      if contains=="yes"
      	if params[:adName].present?
					render text: "yes"
				else
					return "yes"
				end
			else
				if params[:adName].present?
					render text: "no"
				else
					return "no"
				end
			end
  end
  
  ### Upload creative in tmp
  def uploadtempbanner
	ctime=Time.now().to_i
    filename = ''
    if params[:upload]
			filename = ctime.to_s + params[:upload]['datafile'].original_filename
			post = DataFile.savetmp(params[:upload],ctime)
    end
    render text: filename + "@@@"+params[:upload]['datafile'].size.to_s
  end
end
