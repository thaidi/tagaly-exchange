class CampaignsController < ApplicationController
	require 'net/http'
	require 'json'
	layout 'advertiser'
	include CheckSiteIdHelper
	include AdsHelper
	require 'open-uri'

	def nativeadunits
		$campCreation = SparseArray.new
		$adDetails = SparseArray.new
		$editAdDetails = SparseArray.new
		@adunitChannelId = ""
		src =  Tagaly3::SRC
		@uri = URI.parse(src)
		http = Net::HTTP.start(@uri.host,@uri.port)
		request = Net::HTTP::Get.new("/adexchange/publisher/adUnit/listAll")
		response = http.request(request)
		@channelAdunitsList = JSON.parse(response.body)
		@siteIds=Array.new
		@channelAdunitsList.each do |key,adunit|
			if (adunit['adType'] == 'NativeAd') && adunit['status'] == "Active"
				@siteIds.push(adunit['siteId'])
			end
		end
		@channelIds = Array.new
		@allSiteDetails = Publishersite.where("id in (?) AND status = 'Active'", @siteIds)
		@allSiteDetails.each do | allSiteDetails |
			@channelIds.push(allSiteDetails.channel)
			if session[:nativeAdunitChannelId].present? || session[:nativeAdunitChannelId] != nil
				@adunitChannelId = session[:nativeAdunitChannelId]
			else
				session[:nativeAdunitChannelId] = allSiteDetails.channel
				@adunitChannelId = allSiteDetails.channel
			end
		end
		@sitesString = @siteIds.uniq
		if @sitesString.count > 0
			session['adunitsSites'] = @sitesString
		else
			session['adunitsSites'] = [0]
		end
		@allSiteDetailsForChannels = Publishersite.where("channel = '" + @adunitChannelId +"' AND id in (?)" , @sitesString)
		@channels=Array.new
		@channelSitesList = Publishersite.where("id in (?) AND status = 'Active'", @sitesString)
		@channelSitesList.each do |site|
			@channels.push(site.channel)
  	end
	end

	def check
		src =  Tagaly3::SRC
		@uri = URI.parse(src)
		http = Net::HTTP.start(@uri.host,@uri.port)
		request = Net::HTTP::Get.new("/adexchange/publisher/adUnit/listAll")
		response = http.request(request)
		@channelAdunitsList = JSON.parse(response.body)
		@siteIds=Array.new
		@adunitType = "display"
		@channelAdunitsList.each do |key,adunit|
			if (adunit['adType'] == 'DisplayAd' || adunit['adType'] == 'TextAndDisplayAd') && adunit['status'] == "Active"
				@siteIds.push(adunit['siteId'])
			end
		end
		@channelIds = Array.new
		@allSiteDetails = Publishersite.where("id in (?) AND status = 'Active'", @siteIds)
		@allSiteDetails.each do | allSiteDetails |
			@channelIds.push(allSiteDetails.channel)
			if session[:displayAdunitChannelId].present? || session[:displayAdunitChannelId] != nil
				@adunitChannelId = session[:displayAdunitChannelId]
			else
				session[:displayAdunitChannelId] = allSiteDetails.channel
				@adunitChannelId = allSiteDetails.channel
			end
		end
		@sitesString = @siteIds.uniq
		if @sitesString.count > 0
			session['adunitsSites'] = @sitesString
		else
			session['adunitsSites'] = [0]
		end
		@allSiteDetailsForChannels = Publishersite.where("channel = '" + @adunitChannelId +"' AND id in (?)" , @sitesString)
		@channels=Array.new
		@channelSitesList = Publishersite.where("id in (?) AND status = 'Active'", @sitesString)
		@channelSitesList.each do |site|
			@channels.push(site.channel)
  	end
	end

  def graph
		
	end
	def uploadad
		$editAdDetails = SparseArray.new
		adunitIdFromParams = params[:id]
		# $adDetails
		# $campCreation["CampCreation"][adunitId] = adId
		if $campCreation["CampCreation"][adunitIdFromParams].present? || $campCreation["CampCreation"][adunitIdFromParams] != nil
			adIdForCampCreation = $campCreation["CampCreation"][adunitIdFromParams]
			$adDetails[adIdForCampCreation].each do |key,value|
				$editAdDetails["details"][key] = value
			end
		else
			$editAdDetails = SparseArray.new
		end
		if params[:nativead].present?
			adId = (Time.now.to_f * 1000000000).to_i
			adunitId = adunitIdFromParams
			if $adDetails.present? && $campCreation.present?
			else
				$campCreation = SparseArray.new
				$adDetails = SparseArray.new
			end
			$campCreation["CampCreation"][adunitId] = adId
			params[:nativead].each do |key,value|
				if key == "name" || key == "coloredtextbox" || key == "headline" || key == "description" || key == "comments" || key == "authorname" || key == "placeholder" || key == "secondheadline" || key == "categorytitle" || key == "more" || key == "nsotp" || key == "owtoti" || key == "ncotp" || key == "readmore" || key == "multiplecategories" || key == "quotesbelowthephoto" || key == "enabletags" || key == "categorytitleiconorbox" || key == "timeago" || key == "horizontalline" || key == "dividerline" || key == "followmacontwitter" || key == "categorysubtab" || key == "authorbyline" || key == "destinationUrl"
					$adDetails[adId][key] = value
				end
			end
			if params[:nativead]["image"]
				params[:nativead]["datafile"] = params[:nativead]["image"]
			  filename = adId.to_s + params[:nativead]["datafile"].original_filename
			  post = DataFile.save(params[:nativead] , adId)
				$adDetails[adId]["image"] = filename
			end
			if params[:nativead]["authorimage"]
				params[:nativead]["datafile"] = params[:nativead]["authorimage"]
			  filename = adId.to_s + params[:nativead]["datafile"].original_filename
			  post = DataFile.save(params[:nativead] , adId)
				$adDetails[adId]["authorimage"] = filename
			end
			if params[:nativead]["caret"]
				params[:nativead]["datafile"] = params[:nativead]["caret"]
			  filename = adId.to_s + params[:nativead]["datafile"].original_filename
			  post = DataFile.save(params[:nativead] , adId)
				$adDetails[adId]["caret"] = filename
			end
			if params[:nativead]["youtubesnapshot"]
				params[:nativead]["datafile"] = params[:nativead]["youtubesnapshot"]
			  filename = adId.to_s + params[:nativead]["datafile"].original_filename
			  post = DataFile.save(params[:nativead] , adId)
				$adDetails[adId]["youtubesnapshot"] = filename
			end
			if params[:nativead]["videosnapshot"]
				params[:nativead]["datafile"] = params[:nativead]["videosnapshot"]
			  filename = adId.to_s + params[:nativead]["datafile"].original_filename
			  post = DataFile.save(params[:nativead] , adId)
				$adDetails[adId]["videosnapshot"] = filename
			end
			if params[:nativead]["facebooklikeoranysocialmediawidget"]
				params[:nativead]["datafile"] = params[:nativead]["facebooklikeoranysocialmediawidget"]
			  filename = adId.to_s + params[:nativead]["datafile"].original_filename
			  post = DataFile.save(params[:nativead] , adId)
				$adDetails[adId]["facebooklikeoranysocialmediawidget"] = filename
			end
			if params[:nativead]["facebookshare"]
				params[:nativead]["datafile"] = params[:nativead]["facebookshare"]
			  filename = adId.to_s + params[:nativead]["datafile"].original_filename
			  post = DataFile.save(params[:nativead] , adId)
				$adDetails[adId]["facebookshare"] = filename
			end
			if params[:nativead]["googleplusshare"]
				params[:nativead]["datafile"] = params[:nativead]["googleplusshare"]
			  filename = adId.to_s + params[:nativead]["datafile"].original_filename
			  post = DataFile.save(params[:nativead] , adId)
				$adDetails[adId]["googleplusshare"] = filename
			end
			if params[:nativead]["linkedinshare"]
				params[:nativead]["datafile"] = params[:nativead]["linkedinshare"]
			  filename = adId.to_s + params[:nativead]["datafile"].original_filename
			  post = DataFile.save(params[:nativead] , adId)
				$adDetails[adId]["linkedinshare"] = filename
			end
			if params[:nativead]["twittershare"]
				params[:nativead]["datafile"] = params[:nativead]["twittershare"]
			  filename = adId.to_s + params[:nativead]["datafile"].original_filename
			  post = DataFile.save(params[:nativead] , adId)
				$adDetails[adId]["twittershare"] = filename
			end
			if params[:nativead]["seriesoficons"]
				params[:nativead]["datafile"] = params[:nativead]["seriesoficons"]
			  filename = adId.to_s + params[:nativead]["datafile"].original_filename
			  post = DataFile.save(params[:nativead] , adId)
				$adDetails[adId]["seriesoficons"] = filename
			end
			redirect_to "/campaigns/uploadnativeads"
		end
		src =  Tagaly3::SRC
		@uri = URI.parse(src)
		http = Net::HTTP.start(@uri.host,@uri.port)
		@siteId=session[:site_id]
		request = Net::HTTP::Get.new("/adexchange/publisher/adUnit/#{params[:id]}")
		response = http.request(request)
		@code = response.code
		#if @code == '200'
			@adunitDetails = JSON.parse(response.body)
			@adUnitUserId = @adunitDetails['userId']
			@fontDetails = Font.where(publisherid: @adUnitUserId)
		#end
		styleId = @adunitDetails["styleId"]
# render text: "/adexchange/publisher/adUnit/#{params[:id]}"
# render text: @adunitDetails
#=begin
		request = Net::HTTP::Get.new("/adexchange/publisher/nativeStyle/#{styleId}")
		response = http.request(request)
		@nativeAdStyle = JSON.parse(response.body)
		@formdata = SparseArray.new
		@jsonParsedData = JSON.parse(@nativeAdStyle["styleData"])
		@canvasStyle = @nativeAdStyle["canvasStyle"]
		@format = @nativeAdStyle["format"]
		@jsonParsedData.each do |styledata|
			if styledata[1]["valuetype"] == "dynamic"
				key = styledata[0]
				@formdata["formdata"][key] = "yes"
			end
		end
#=end
	end
	def uploadnativeads
	#### Set impressions session on change
	if params[:setimpression].present? && params[:setimpression]=="yes"
		if session[:imps].present?
			session[:imps].delete_if{|k,_| k == params[:adunitid]}
			session[:imps].merge!(params[:adunitid]=> params[:impression])
		else
			session[:imps]={params[:adunitid]=> params[:impression]}
		end
	end
		if params[:adunitdeleted].present? && params[:adunitdeleted]!=nil
			@adunitsArr=$adunits.split(/,/)
			@adunitsArr.delete(params[:adunitdeleted])
			$adunits=@adunitsArr.join(",")
			@adUnits=session[:adunitsAds]
			adId=@adUnits[params[:adunitdeleted]]
			@ads=session[:ads]
			@ads.delete(adId)
			session[:ads]=@ads
			
			render text: $adunits.to_s + "@@@" +@ads.to_s
		else
				if params[:adunits].present? 
					$adunits=params[:adunitsstring]
				end
				@sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
				#### Get all adunits
				src =  Tagaly3::SRC
				@uri = URI.parse(src)
				http = Net::HTTP.start(@uri.host,@uri.port)
				@siteId=session[:site_id]
				request = Net::HTTP::Get.new("/adexchange/publisher/adUnit/listAll")
				response = http.request(request)
			 	@adunitsData = JSON.parse(response.body)
				http.finish
		
				####Get ads
				src =  Tagaly3::SRC
				  @uri = URI.parse(src)
				  http = Net::HTTP.start(@uri.host,@uri.port)
				  @siteId=session[:site_id]
					request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/nonAssignedList/#{@siteId}")
					response = http.request(request)
				 	@adsData = JSON.parse(response.body)
					@ads=@adsData
					http.finish
			end
		
	end
	def nativeadunits

		$campCreation = SparseArray.new
		$adDetails = SparseArray.new
		$editAdDetails = SparseArray.new
    src =  Tagaly3::SRC
    @uri = URI.parse(src)
		http = Net::HTTP.start(@uri.host,@uri.port)
	  request = Net::HTTP::Get.new("/adexchange/publisher/adUnit/listAll")
	  response = http.request(request)
	  @allAdunits = JSON.parse(response.body)
		@siteIds = Array.new
		@channelIds = Array.new
		@allAdunits.each do |adunitId , adunitDetails|
			if adunitDetails["adType"] == "NativeAd"
				@siteIds.push(adunitDetails['siteId'])
			end
		end

			@sitesString=@siteIds.uniq
			if @sitesString.count > 0
				session['nativeadunitsSites']=@sitesString
			else
				session['nativeadunitsSites']=[0]
			end
			@channels=Array.new
			@channelSitesList = Publishersite.where("id in (?) AND status = 'Active'", @sitesString)
			@channelSitesList.each do |site|
				@channels.push(site.channel)
			end

		@allSiteDetails = Publishersite.where("id in (?) AND status = 'Active'", @siteIds)
		@allSiteDetails.each do | allSiteDetails |
			@channelIds.push(allSiteDetails.channel)
			if session[:nativeAdunitChannelId].present? || session[:nativeAdunitChannelId] != nil
				@nativeAdunitChannelId = session[:nativeAdunitChannelId]
			else
				session[:nativeAdunitChannelId] = allSiteDetails.channel
				@nativeAdunitChannelId = allSiteDetails.channel
			end
		end
		@allSiteDetailsForChannels = Publishersite.where("channel = '" + @nativeAdunitChannelId +"' AND id in (?)" , @sitesString)
		#@nativeAdunitChannelId
=begin
	  request = Net::HTTP::Get.new("/adexchange/publisher/adUnit/listAll")
	  response = http.request(request)
	  @allAdunits = JSON.parse(response.body)
=end

	end

  def index

		if session[:user_id] == '' || session[:user_id] == nil
		  redirect_to '/login'
		else
		@retargets = Retarget.where(siteId: session[:site_id])
    @sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
		campaignId = ""
    if params[:campaignId].present?
			campaignId = params[:campaignId]
		else
			redirect_to "/mycampaigns"
		end
		usrtimeZone = Rack::Utils.escape(session[:user_timezone])
    src =  Tagaly3::SRC
    @uri = URI.parse(src)
		http = Net::HTTP.start(@uri.host,@uri.port)
    # Code to connect to API to get data of all th adunits add by current user.
		#URI.parse(src)
if campaignId != ""
    request = Net::HTTP::Get.new("/adexchange/advertiser/campaign/#{campaignId}")
    response = http.request(request)
    ### Response code
    @code = response.code
    @campaignDetails = JSON.parse(response.body)
end
		if params[:displayType] == "details"

		  request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/dashboard/campaignId/#{campaignId}/all/#{usrtimeZone}/#{session[:startdate]}%2000:00:00/#{session[:enddate]}%2023:59:59/name/0/10")
		  response = http.request(request)
		  @adsDetailsByCampId = JSON.parse(response.body)
			if @adsDetailsByCampId != nil
				@adsDetailsByCampIdStats = @adsDetailsByCampId["stats"]
				@adsDetailsByCampIdTotals = @adsDetailsByCampId["totals"]
			else
				@adsDetailsByCampIdStats = ""
				@adsDetailsByCampIdTotals = ""
			end
		  getCampDetailsrequest = Net::HTTP::Get.new("/adexchange/advertiser/campaign/#{campaignId}")
		  getCampDetailsresponse = http.request(getCampDetailsrequest)
			@campDetails = JSON.parse(getCampDetailsresponse.body)
			#render text: @campDetails
			##Get adunits for ad placements type of campaign
			if @campDetails['campaignType']=='ad_placement'
			getAdUnitsRequest = Net::HTTP::Get.new("/adexchange/advertiser/campaign/#{campaignId}/listAdUnits")
			getAdUnitsResponse=http.request(getAdUnitsRequest)
			@adUnitsDetails = JSON.parse(getAdUnitsResponse.body)
			end
		elsif params[:displayType] == "graph"
@srcccc = "/adexchange/advertiser/advertisement/dashboard/graph/campaignId/#{campaignId}/all/#{usrtimeZone}/#{session[:startdate]}%2000:00:00/#{session[:enddate]}%2023:59:59"
		  graphrequest = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/dashboard/graph/campaignId/#{campaignId}/all/#{usrtimeZone}/#{session[:startdate]}%2000:00:00/#{session[:enddate]}%2023:59:59")
		  graphresponse = http.request(graphrequest)
			@graphDataForCamp = JSON.parse(graphresponse.body)
			render 'graph' , :layout => false
		end
    http.finish
#render text: @adUnitsDetails
    # render 'conversions' ,:layout => false
	end
  end
  
  
  #### New Campaign Creation
  def new
		if session[:user_id] == '' || session[:user_id] == nil
		  redirect_to '/login'
		else
    #@campaign = Campaign.new
    @sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
    
    #### Get campaigns list for minimum bid price suggestion
    @siteId=session[:site_id]
    src =  Tagaly3::SRC
    @uri = URI.parse(src)
    http = Net::HTTP.start(@uri.host,@uri.port)
		request = Net::HTTP::Get.new("/adexchange/advertiser/campaign/list/#{@siteId}")
    response = http.request(request)
    @campaigns=JSON.parse(response.body)
      
    #### Get retargets list
    @retargets = Retarget.where(siteId: session[:site_id])
    retargetsss=''
     if @retargets.present?
     exce = 'yes'
     @retargets.each do |retarget|
     exce = 'yes'
     retargetsss = retargetsss + retarget.id.to_s + ","
     end
     end
     if exce == 'yes'
     src=Tagaly3::SRC + "/adexchange/trackAudience/list/#{session[:site_id]}/#{retargetsss}"
     url = URI.parse(src)
     req = Net::HTTP::Get.new(url.to_s)
     res = Net::HTTP.start(url.host, url.port) {|http|
     http.request(req)
     }
     resp=res.body
     respcode=res.code
     @retargetCount = JSON.parse(resp)     
     #http.finish()
     end
     
     #### Get the host site script
     @result=''
			if session[:site_url] != nil
				
				  begin
				  @result = open(session[:site_url]).read
				  rescue OpenURI::HTTPError
				  @failure =""
				  rescue SocketError
				  @failure =""
				  rescue Exception
				  @failure =""
				  else
				  @success =""
				  end
			else
				@result=''
			end
     
     @siteId=session[:site_id]
     userId=session[:user_id]
    @conversion_goals = Conversion.where(siteId: session[:site_id])
    @host = Socket.gethostname
    userId = session[:user_id]
    src =  Tagaly3::SRC
    # Code to connect to API to get data of all the ads add by current user.
    @uri = URI.parse(src)
    http = Net::HTTP.new(@uri.host,@uri.port)
    #/adexchange/advertiser/advertisement/nonAssignedList/#{@siteId}
    #/adexchange/advertiser/advertisement/list/#{userId}
    @startdate=Date.today - 365
    @enddate=Date.today
    if session[:user_timezone] != nil
      @timezone=session[:user_timezone].dup
    else
      @timezone='UTC'
    end
    @timezone=@timezone.sub! '/', '%2F'
####"/adexchange/advertiser/advertisement/dashboard/siteId/#{@siteId}/All/All/#{@timezone}/#{@startdate.to_s+"%2000:00:00"}/#{@enddate.to_s+"%2023:59:59"}/name/0/10"
    request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/nonAssignedList/#{@siteId}")
    response = http.request(request)
   	@adsData = JSON.parse(response.body)
		@ads=@adsData
		#render text: @ads
		#@adsStats=@adsData['stats']
    if session[:user_timezone] != nil
      session[:user_timezone]=@timezone.sub! '%2F','/'
    end

    #### Conversions
    request = Net::HTTP::Get.new("/adexchange/advertiser/conversion/list/#{@siteId}")
    response = http.request(request)
    @code = response.code
    @conversionsList = JSON.parse(response.body)
  
	end  
  end
  
  #### Create campaign starts here
  
  def create

			src =  Tagaly3::SRC
			@uri = URI.parse(src)
			http = Net::HTTP.start(@uri.host,@uri.port)
   @sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
    x=params[:campaign][:countDayparting].to_i
    
    i=1
    dayparting=''
    dayp=''
    hr1p=''
    min1p=''
    hr2p=''
    min2p=''
    
    retargetString=''
    coversionGoalsString=''
    httpRequest=''
	if params[:campaign][:retargets].present?
		params[:campaign][:retargets].each do |retarget|
		  retargetString = retargetString + "&retargeting=" + retarget
		end
	end
		 if params[:campaign][:conversions].present?
		  params[:campaign][:conversions].each do |conversion|
		    coversionGoalsString = params[:campaign][:conversions].join(',')
		  end
		end

    Date.strptime(DateTime.now.to_s).strftime("%m/%d/%Y")
    now = Time.now.in_time_zone(session[:user_timezone])
    campaign_start_date=Time.strptime(now.to_s,"%Y-%m-%d").strftime("%Y-%m-%d")
    if params[:campaign][:runcampaigncontinuously] == 'ongoing'
      startDate=campaign_start_date
      endDate=''
    else
      startDate=params[:campaign][:campaign_startdate]
      endDate=params[:campaign][:campaign_enddate]
    end
    
@adIdscreated = Array.new
		if params["campaign"]["camptype"] == "NativeCampaign"
			params["campaign"]["campaign_type"] = "native_ad_placement"
			@adunitsArr = params["campaign"][:adunits].split(/,/)
			@adunitsArr.each do |eachAdunitId|
				qty = ""
				qty = session[:imps]["#{eachAdunitId}"].to_i * 1000
				adIdForAdunit = $campCreation["CampCreation"][eachAdunitId]
				adIdDetails = $adDetails[adIdForAdunit]
				jsonStringArray = Array.new
				nAdUnitName = ""
				nAdUnitdestinationUrl = ""
				adIdDetails.each do |element,elementdata|
					if element.to_s == "name"
						nAdUnitName = elementdata
					elsif element.to_s == "destinationUrl"
						nAdUnitdestinationUrl = elementdata
					end
					jsonString = " '#{element}' : '#{elementdata}' "
					jsonStringArray.push(jsonString)
				end
				@finalString = jsonStringArray.join(",")
				@finalString = " { " + @finalString + " } "
      	request = Net::HTTP::Put.new("/adexchange/advertiser/advertisement")
				# request = Net::HTTP::Put.new("/adexchange/publisher/nativeStyle" , {'Content-Type' =>'application/json'})
				request.set_form_data({"adUnitId"=> eachAdunitId , "advertiserId" => session[:user_id], "siteId" => session[:site_id], "adType" => "NativeAd" , "adName" => nAdUnitName ,	"adDestinationUrl" => nAdUnitdestinationUrl ,	"adStatus"=>"Active" ,"version"=> "1.0".to_f , "nativeAdData" => @finalString , "volume" => qty })
		  	response = http.request(request)
				@code = response.code
				@body = response.body
				@adIdscreated.push(@body)
			end
				ads = @adIdscreated.join(",")
				campaignStatus=params[:campaign][:state]
				$campCreation = SparseArray.new
				$adDetails = SparseArray.new
		else
		  if params[:campaign][:campaign_type] == 'ad_placement'
				ads = ""
				adunits = ""
				$adunits.each do |adunitId|
					adunits = adunitId.to_s + "," + adunits.to_s
					qty = params[:qty][adunitId].to_i * 1000
					userId = session[:user_id]
					siteId = session[:site_id]
					if $banneradDetails[adunitId]["adType"] == "Create"
						adName = $banneradDetails[adunitId]['adName']
						destUrl = $banneradDetails[adunitId]['destination_url']
						imgUrl = $banneradDetails[adunitId]['imgUrl']
						adSize = $banneradDetails[adunitId]["adSize"]
						adType = "BannerAd"
				  	request = Net::HTTP::Put.new("/adexchange/advertiser/advertisement")
						# request = Net::HTTP::Put.new("/adexchange/publisher/nativeStyle" , {'Content-Type' =>'application/json'})
						request.set_form_data({"adUnitId"=> adunitId , "advertiserId" => userId , "siteId" => siteId , "adType" => adType , "adName" => adName ,	"adDestinationUrl" => destUrl ,	"adStatus"=>"Active" , "adImageUrl" => imgUrl , "version"=> "1.0".to_f , "volume" => qty , "adSize" => adSize })
						response = http.request(request)
						@code = response.code
						@body = response.body
						ads = @body.to_s + "," + ads
					else
						adId = $banneradDetails[adunitId]["lidAdId"]
						@copiedId = copyAd("#{adId}","2.0","","#{adunitId}")
						ads = @copiedId.to_s + "," + ads
					end
					# ===========
				end
				campaignStatus="pause"
=begin
				ads=params[:campaign][:ads]
				campaignStatus="pause"
=end
			else
				ads=params[:campaign][:ads].join(',')
				campaignStatus=params[:campaign][:state]
			end		
			campaignStatus=params[:campaign][:state]
		end
			campaignStatus=params[:campaign][:state]
	@adslist=ads.split(",")
    #### Create a copy of the ads assigned to this campaign
   
    #### Arrage the dayparting according to the API
    
		if params[:campaign][:campaign_type] !='ad_placement'
				while i <= x
				  dayp="dayparting_day" + i.to_s
				  hr1p="dayparting_start_hr" + i.to_s
				  min1p="dayparting_start_min" + i.to_s
				  hr2p="dayparting_end_hr" + i.to_s
				  min2p="dayparting_end_min" + i.to_s
				  dayparting = dayparting + params[:campaign][dayp].to_s + "|" + params[:campaign][hr1p].to_s + ":" + params[:campaign][min1p].to_s + "|" + params[:campaign][hr2p].to_s + ":" + params[:campaign][min2p].to_s  + ","
				  i=i+1
				end
				dayparting=dayparting.chomp(",")
				
				geotargetingtype=params[:campaign][:geotargeting]
				geotargetingValue=params[:campaign][geotargetingtype].join(" , ")
				volume=0
				price=0
				if params[:campaign][:bidtype]=="cpc"
				  volume=params[:campaign][:clicks].to_i
				  price=params[:campaign][:cpc].to_f
				elsif params[:campaign][:bidtype]=="cpm"
				  volume=params[:campaign][:impressions].to_i
				  price=params[:campaign][:cpm].to_f
				else params[:campaign][:bidtype]=="cpa"
				  volume=params[:campaign][:conversionscpa].to_i
				  price=params[:campaign][:cpa].to_f
				end
				if params[:campaign][:runadcontinuously] == 'ongoing'
				  dayparting="all"
				end
				if params[:campaign][:targetallusers]=="no-retargets"
				  @retargets=0
				else
				  @retargets=params[:campaign][:retargets].join(',')
				end
				if params[:campaign][:campaign_type]=="ad_placement"
					adunits=adunits
				else
					adunits=0
				end
		end
    #render text: @retargets
    src =  Tagaly3::SRC
    @HOST_NAME = Tagaly3::HOST_NAME
    @host = Socket.gethostname
    @uri = URI.parse(src)
    http = Net::HTTP.new(@uri.host,@uri.port)
    request = Net::HTTP::Put.new("/adexchange/advertiser/campaign")

		if params[:campaign][:campaign_type] !='ad_placement'
    	request.set_form_data({"campaignName"=>params[:campaign][:campaign_name],"advertiserId"=>session[:user_id],"siteId"=>session[:site_id],"budget"=>params[:campaign][:weekly_budget] , "campaignStartDate"=>startDate,"campaignEndDate"=>endDate , "campaignStatus"=>campaignStatus , "frequencyCaping"=>200,"adRotation"=>"test","volume"=>volume,"price"=>price,"currency"=>"$",
	"campaignType"=>params[:campaign][:campaign_type],"bidType"=>params[:campaign][:bidtype],"geoTargetingType"=>params[:campaign][:geotargeting],"adId"=>ads,"retargeting"=>@retargets,"coversionGoals"=>coversionGoalsString,"geoTargeting"=>geotargetingValue.to_s , "dayParting"=>dayparting,"devicePreference"=>params[:campaign][:device_preferences],"adUnitId"=>adunits})
		else
    	request.set_form_data({"campaignName"=>params[:campaign][:campaign_name] , "advertiserId"=>session[:user_id],"siteId"=>session[:site_id] , "budget"=>params[:campaign][:weekly_budget] , "campaignStartDate"=>startDate , "campaignEndDate"=>endDate , "campaignStatus"=> "Pause" , "campaignType"=>params[:campaign][:campaign_type] , "adId"=>ads , "devicePreference"=>params[:campaign][:device_preferences] , "adUnitId"=>adunits , "coversionGoals"=>coversionGoalsString })
		end

		$campCreation = SparseArray.new
		$adDetails = SparseArray.new
    ### Get Response
    response = http.request(request)
    @code = response.code
		campaignId=response.body
    if @code=='200'
	
		 @adslist.each do |adId|
		#render text: params[:campaign][:ads]
		if params["campaign"]["camptype"] != "NativeCampaign"
			#@copiedId=copyAd("#{adId}","2.0","")
		end

			src =  Tagaly3::SRC
			@HOST_NAME = Tagaly3::HOST_NAME
			@host = Socket.gethostname
			@uri = URI.parse(src)
			http = Net::HTTP.new(@uri.host,@uri.port)
			request = Net::HTTP::Post.new("/adexchange/advertiser/advertisement/#{adId}")
			request.set_form_data({"approvalStatus"=>"PendingApproval","campaignId"=>campaignId.to_i})
			### Get Response
			response = http.request(request)
			@code = response.code
		end

		  if params[:campaign][:campaign_type] == 'ad_placement' || params["campaign"]["camptype"] == "NativeCampaign"
      	flash[:notice]="Campaign created successfully. Your campaigns will go live as soon as the publisher approves them."
			else
      	flash[:notice]="Campaign created successfully"
			end
    else
      flash[:error]="Some problem occured while campaign creation ! Please contact the administrator ."
    end
	if params[:campaign][:campaign_type]=="ad_placement"
		redirect_to "/campaigns/checkout"
	else
	
	redirect_to "/dashboard/#{session[:site_id]}"
	end

  end
  ### Create campaign ends here
  
  
  #### Update campaign status
  
  def updatestatus
	## ads
	src =  Tagaly3::SRC
    @HOST_NAME = Tagaly3::HOST_NAME
    @host = Socket.gethostname
	@userId=session[:user_id]
    @uri = URI.parse(src)
    http = Net::HTTP.new(@uri.host,@uri.port)

	@userId=session[:user_id]
    request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/list/#{@userId}")

    ### Get Response
    response = http.request(request)
    @AdData = JSON.parse(response.body)
	## campaign
	
	src =  Tagaly3::SRC
    @HOST_NAME = Tagaly3::HOST_NAME
    @host = Socket.gethostname
    @uri = URI.parse(src)
    http = Net::HTTP.start(@uri.host,@uri.port)
    #1389090644
    request = Net::HTTP::Get.new("/adexchange/advertiser/campaign/#{params[:campaignid]}")
	response = http.request(request)
	@campaigndetails = JSON.parse(response.body)
    src =  Tagaly3::SRC
    @HOST_NAME = Tagaly3::HOST_NAME
    @host = Socket.gethostname
    @uri = URI.parse(src)
    http = Net::HTTP.new(@uri.host,@uri.port)
    request = Net::HTTP::Post.new("/adexchange/advertiser/campaign/#{params[:campaignid]}")
    request.set_form_data({"campaignStatus"=>params[:status]})
    ### Get Response
    response = http.request(request)
    @code = response.code
     #Campaign.where("`campaigns`.`id` = '#{params[:campaignid]}'").update_all(:cam_status => params[:status])
	 @pausearray = Array.new
	 @campaigndetails["adId"].each do |adId|
		if @AdData["#{adId}"]['adStatus'] == "Paused"
			@pausearray=@pausearray.push("Paused")
		else
			@pausearray.push("other")
		end
	 end
	 if @pausearray.count("Paused") == @pausearray.size && params[:status]=="active"
		render text: "adpaused"
	else
     render text: "success"
	end
  end
  
  def updatebudget
    src =  Tagaly3::SRC
    @HOST_NAME = Tagaly3::HOST_NAME
    @host = Socket.gethostname
    @uri = URI.parse(src)
    http = Net::HTTP.new(@uri.host,@uri.port)
    request = Net::HTTP::Post.new("/adexchange/advertiser/campaign/#{params[:campaignid].to_i}")
    request.set_form_data({"budget"=>params[:budget]})
    ### Get Response
    response = http.request(request)
    @code = response.code
     #Campaign.where("`campaigns`.`id` = '#{params[:campaignid]}'").update_all(:cam_status => params[:status])
     render text: @code
  end
  
  
  ### Edit Campaign starts here
  def edit
		if session[:user_id] == '' || session[:user_id] == nil
		  redirect_to '/login'
		else
    @sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
    @result=''
    @host = Socket.gethostname
    @siteId = session[:site_id]
    userId = session[:user_id]
    src =  Tagaly3::SRC
    # Code to connect to API to get data of all the ads add by current user.
    @uri = URI.parse(src)
    http = Net::HTTP.start(@uri.host,@uri.port)
    @startdate=Date.today - 365
    @enddate=Date.today
    if session[:user_timezone] != nil
      @timezone=session[:user_timezone].dup
    else
      @timezone='UTC'
    end
    @timezone=@timezone.sub! '/', '%2F'

    request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/nonAssignedList/#{@siteId}")
    response = http.request(request)
    @adsData = JSON.parse(response.body)
    @ads=@adsData
    if session[:user_timezone] != nil
      session[:user_timezone]=@timezone.sub! '%2F','/'
    end
    
    http.finish
    #render text: @ads
    ### campaign related ads code starts here
    startdate = Date.today - 1.year
    enddate = Date.today
    if session[:user_timezone] != nil
      @timezone=session[:user_timezone].dup
     else
      @timezone='UTC'
     end
     @timezone=@timezone.sub! '/', '%2F'

     http = Net::HTTP.start(@uri.host,@uri.port)
     request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/dashboard/campaignId/#{params[:id]}/ActiveOrPaused/#{@timezone}/#{startdate.to_s+"%2000:00:00"}/#{enddate.to_s+"%2023:59:59"}/name/0/10")
     response = http.request(request)
     @campaignAdsAll = JSON.parse(response.body)
     @campaignAds=@campaignAdsAll["stats"]
     http.finish
     if session[:user_timezone] != nil
        session[:user_timezone]=@timezone.sub! '%2F','/'
      end
     ### campaign related ads code ends here
	 ### Adunits list code
     http = Net::HTTP.start(@uri.host,@uri.port)
     request = Net::HTTP::Get.new("/adexchange/publisher/adUnit/listAll")
     response = http.request(request)
     @allAdUnits = JSON.parse(response.body)
     http.finish
	 
	 
    @retargets = Retarget.where(siteId: session[:site_id])
    retargetsss=''
     if @retargets.present?
     exce = 'yes'
     @retargets.each do |retarget|
     exce = 'yes'
     retargetsss = retargetsss + retarget.id.to_s + ","
     end
     end
     if exce == 'yes'
     src = Tagaly3::SRC + "/adexchange/trackAudience/list/#{session[:site_id]}/#{retargetsss}"
     url = URI.parse(src)
     req = Net::HTTP::Get.new(url.to_s)
     res = Net::HTTP.start(url.host, url.port) {|http| http.request(req) }
     resp=res.body
     respcode=res.code
     @retargetCount = JSON.parse(resp)     
     #http.finish()
     end
    @conversion_goals = Conversion.where(siteId: session[:site_id])
    
    src =  Tagaly3::SRC
    @HOST_NAME = Tagaly3::HOST_NAME
    @host = Socket.gethostname
    @uri = URI.parse(src)
    http = Net::HTTP.start(@uri.host,@uri.port)
    #1389090644
    request = Net::HTTP::Get.new("/adexchange/advertiser/campaign/#{params[:id]}")
		
     ### Get Response
    response = http.request(request)
    ### Response code
    @code = response.code
    @campaignDetails = JSON.parse(response.body)

		@returnValue = checkSiteId(@campaignDetails,'advertiser')
		if @returnValue == false
			render_404
		end
    #render text: @campaignDetails
    @siteId=session[:site_id]
    #### Conversions
    request = Net::HTTP::Get.new("/adexchange/advertiser/conversion/list/#{@siteId}")
    response = http.request(request)
    @code = response.code
    @conversionsList = JSON.parse(response.body)
    http.finish
    
    #render text: @campaignDetails
    if params[:campaign]
      x=params[:campaign][:countDayparting].to_i
    i=1
    dayparting=''
    dayp=''
    hr1p=''
    min1p=''
    hr2p=''
    min2p=''
    ads=Array.new
    ads=params[:campaign][:ads]
    adsString=''
    retargetString=''
    coversionGoalsString=''
    httpRequest=''
    ads.each do |ad|
      adsString = adsString + "&adId=" + ad
    end
		if params[:campaign][:conversions].present?
		  params[:campaign][:conversions].each do |conversion|
		    coversionGoalsString = params[:campaign][:conversions].join(',')
		  end
		end

    if params[:campaign][:runcampaigncontinuously] == 'ongoing'
      startDate=params[:campaign][:campaign_startdate]
      endDate=''
    else
      startDate=params[:campaign][:campaign_startdate]
      endDate=params[:campaign][:campaign_enddate]
    end
    volume=0
    price=0
    if params[:campaign][:bidtype]=="cpc"
      volume=params[:campaign][:clicks].to_i
      price=params[:campaign][:cpc].to_f
    elsif params[:campaign][:bidtype]=="cpm"
      volume=params[:campaign][:impressions].to_i
      price=params[:campaign][:cpm].to_f
    elsif params[:campaign][:bidtype]=="cpa"
      volume=params[:campaign][:conversionscpa].to_i
      price=params[:campaign][:cpa].to_f
    end
    
    #### Arrage the dayparting according to the API
    
    while i <= x
      dayp="dayparting_day" + i.to_s
      hr1p="dayparting_start_hr" + i.to_s
      min1p="dayparting_start_min" + i.to_s
      hr2p="dayparting_end_hr" + i.to_s
      min2p="dayparting_end_min" + i.to_s
      dayparting = dayparting + params[:campaign][dayp].to_s + "|" + params[:campaign][hr1p].to_s + ":" + params[:campaign][min1p].to_s + "|" + params[:campaign][hr2p].to_s + ":" + params[:campaign][min2p].to_s  + ","
      i= i+1
    end
    dayparting=dayparting.chomp(",")
    geotargetingtype=params[:campaign][:geotargeting]
    geotargetingValue=params[:campaign][geotargetingtype].join(",")
    if params[:campaign][:runadcontinuously] == 'ongoing'
      dayparting="all"
    end
    if params[:campaign][:targetallusers]=="no-retargets"
      @retargets=0
    else
      @retargets=params[:campaign][:retargets].join(',')
    end
	if params[:campaign][:campaign_type]=="ad_placement"
		adunits=params[:campaign][:adunits].join(",")
	else
		adunits=0
	end
	#### Create a copy of the ad which are assigned newly
	@setadstatus=Array.new
	params[:campaign][:ads].each do |adid|
		if @ads.has_key?(adid)
			@copiedAdId=copyAd("#{adid}","2.0","")
		else 
			adStatusIs = @campaignAds[adid]["advertisementDetails"]["adStatus"]
			@setadstatus.push(@campaignAds[adid]["advertisementDetails"]["adStatus"])
		end
	end

	if @setadstatus.all? {|x| x == @setadstatus[0]} && @setadstatus[0]=="Paused"
		@campaignStatus="pause"
	else
		@campaignStatus=params[:campaign][:state]
	end
    src =  Tagaly3::SRC
    @HOST_NAME = Tagaly3::HOST_NAME
    @host = Socket.gethostname
    @uri = URI.parse(src)
    http = Net::HTTP.start(@uri.host,@uri.port)
    request = Net::HTTP::Post.new("/adexchange/advertiser/campaign/#{params[:id]}")
    request.set_form_data({"campaignName"=>params[:campaign][:campaign_name],"advertiserId"=>session[:user_id],"siteId"=>session[:site_id],"budget"=>params[:campaign][:weekly_budget],"campaignStartDate"=>startDate, "campaignEndDate"=>endDate,"campaignStatus"=>@campaignStatus, "frequencyCaping"=>200,"adRotation"=>"test","volume"=>volume, "price"=>price,"currency"=>"$", "bidType"=>params[:campaign][:bidtype], "geoTargetingType"=>params[:campaign][:geotargeting], "adId"=>params[:campaign][:ads].join(','), "retargeting"=>@retargets, "coversionGoals"=>coversionGoalsString, "geoTargeting"=>geotargetingValue.to_s,"dayParting"=>dayparting,"devicePreference"=>params[:campaign][:device_preferences], "adUnitId"=>adunits})
    ### Get Response
    response = http.request(request)
    @code = response.code
    http.finish
    if @code=='200'
      flash[:notice]="Campaign Edited successfully"
    else
      flash[:error]="Some problem occured while campaign editing ! Please contact the administrator ."
    end
    #render text: response.body
    redirect_to "/dashboard/#{session[:site_id]}"
    #redirect_to
    end
#=end
    end
  end
# Campaign Edit Ends Here


  def update
    
  end
  def abc
		h = { 'dog' => 'canine', 'cat' => 'feline', 'donkey' => 'asinine' }
		CSV.open("data.csv", "wb") {|csv| h.to_a.each {|elem| csv << elem} }
	end
	
	#### Start campaign page action
	def startCampaign
		@sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
	end
	
	#### Campaigns list action
	def list
		if session[:user_id] == '' || session[:user_id] == nil
		  redirect_to '/login'
		else
			@sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
			if @sites.count > 0 
				@startdate=Date.today - 1.year
				@enddate=Date.today
				if session[:user_timezone] != nil
					@timezone=session[:user_timezone].dup
				else
					@timezone='UTC'
				end
			 	@timezone=@timezone.sub! '/', '%2F'
				@siteId=session[:site_id]
				src =  Tagaly3::SRC
				@uri = URI.parse(src)
				http = Net::HTTP.start(@uri.host,@uri.port)
				request = Net::HTTP::Get.new("/adexchange/advertiser/campaign/dashboard/siteId/#{@siteId}/activerorpause/#{@timezone}/#{@startdate.to_s+"%2000:00:00"}/#{@enddate.to_s+"%2023:59:59"}/name/0/10")
				response = http.request(request)
				begin
					if response.body != ""
						@CampData = JSON.parse(response.body)
						@CampDataStats = @CampData["stats"]
					else
						@CampData = Array.new
						@CampDataStats = Array.new
					end
				end
				if session[:user_timezone] != nil
						session[:user_timezone]=@timezone.sub! '%2F','/'
				end
				if @CampDataStats.present? && @CampDataStats.count > 0
				else
					if params[:aft]=='1'
						redirect_to "/campaigns/startCampaign?aft=1"
					else
						redirect_to "/campaigns/startCampaign"
					end
				end
			else
				redirect_to "/users/introduction"
			end
		end
	end
	
	#### Adunits actions for ad placements campaign type
	def adunits
			session[:ads]=""
			session[:adunitsAds]=""
			session[:adImageUrls]=""
		$campCreation = SparseArray.new
		$adDetails = SparseArray.new
		$editAdDetails = SparseArray.new
		$adsDetailsForAdunit = SparseArray.new
		$banneradDetails = SparseArray.new

		@adunitChannelId = ""
		src =  Tagaly3::SRC
		@uri = URI.parse(src)
		http = Net::HTTP.start(@uri.host,@uri.port)
		request = Net::HTTP::Get.new("/adexchange/publisher/adUnit/listAll")
		response = http.request(request)
		@channelAdunitsList = JSON.parse(response.body)
		@siteIds=Array.new
		@channelAdunitsList.each do |key,adunit|
			if (adunit['adType'] == 'DisplayAd' || adunit['adType'] == 'TextAndDisplayAd') && adunit['status'] == "Active"
				@siteIds.push(adunit['siteId'])
			end
		end
		@channelIds = Array.new
		@allSiteDetails = Publishersite.where("id in (?) AND status = 'Active'", @siteIds)
		@allSiteDetails.each do | allSiteDetails |
			@channelIds.push(allSiteDetails.channel)
			if session[:displayAdunitChannelId].present? || session[:displayAdunitChannelId] != nil
				@adunitChannelId = session[:displayAdunitChannelId]
			else
				session[:displayAdunitChannelId] = allSiteDetails.channel
				@adunitChannelId = allSiteDetails.channel
			end
		end
		@sitesString = @siteIds.uniq
		if @sitesString.count > 0
			session['adunitsSites'] = @sitesString
		else
			session['adunitsSites'] = [0]
		end
		@allSiteDetailsForChannels = Publishersite.where("channel = '" + @adunitChannelId +"' AND id in (?)" , @sitesString)
		@channels=Array.new
		@channelSitesList = Publishersite.where("id in (?) AND status = 'Active'", @sitesString)
		@channelSitesList.each do |site|
			@channels.push(site.channel)
  	end
		if params[:frame] == "frame"
			render :layout => false 
		end

	  #render text: @channels
	#@channelSitesList = Publishersite.where( status: 'Active').limit(15)
	end
	def deleteplacements
		if params[:adunitdeleted].present?
			$adunits.delete(params[:adunitdeleted])
		end
	end
	#### Upload creative
	def upload
		# $banneradDetails = SparseArray.new
		# check if id is there in ur or not
		@sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
		if params[:ad].present?
			if params[:fromLibrary]
				adunitId = params[:id]
				ladparams = params[:libraryad].split(/&&&/)
				$banneradDetails[adunitId]["adType"] = "Library"
				$banneradDetails[adunitId]["lidAdId"] = ladparams[0]
				$banneradDetails[adunitId]["imgUrl"] = ladparams[1]
				$banneradDetails[adunitId]["adSize"] = params[:ad][:adSize]
				url = ladparams[1]
				redirect_to "/campaigns/saveAdunits?saveAdunitId=#{adunitId}&url=#{url}"
			else
				# created here
				ctime=Time.now().to_i
				filename = ''
				if params[:uploadType] == "new"
					if params[:upload]
						filename = ctime.to_s + params[:upload]['datafile'].original_filename
						post = DataFile.save(params[:upload],ctime)
					end
				else
					filename = params[:prevUploadImgUrl]
				end
				adunitId = params[:id]
				$banneradDetails[adunitId]["adType"] = "Create"
				$banneradDetails[adunitId]["adName"] = params[:ad][:ad_name]
				$banneradDetails[adunitId]["imgUrl"] = filename
				$banneradDetails[adunitId]["destination_url"] = params[:ad][:destination_url]
				$banneradDetails[adunitId]["adSize"] = params[:ad][:adSize]
				url = filename
				redirect_to "/campaigns/saveAdunits?saveAdunitId=#{adunitId}&url=#{url}"
			end
		else
			# if no post values
			if params[:id].present?
				src =  Tagaly3::SRC
				@uri = URI.parse(src)
				http = Net::HTTP.start(@uri.host,@uri.port)
				@siteId=session[:site_id]
				request = Net::HTTP::Get.new("/adexchange/publisher/adUnit/#{params[:id]}")
				response = http.request(request)
				@code = response.code
				if @code == '200'
					@adunitDetails = JSON.parse(response.body)
					if @adunitDetails.present?
						format = @adunitDetails['format']
						request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/nonAssignedAdsMatchingAdPlacement/#{session[:site_id]}/#{format}")
						response = http.request(request)
						@code = response.code
						if @code == '200'
							@libraryAds = JSON.parse(response.body)
						end
						render 'upload' , :layout => false
					else
						#data is null
					end
				else
					#Some problem occured while loading
					@adunitDetails = ""
				end
			else
			
			end
		end
	end
	def saveAdunits
		#render :layout => false
		@currentAdunits = Array.new
		if params["adunitsstring"].present? 
			$adunits = params["adunitsstring"].split(",")
			redirect_to "/campaigns/uploadcreatives"
		end
	end

	def uploadcreatives
		@sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
		@siteId=session[:site_id]
		#### Get all adunits
		src =  Tagaly3::SRC
		@uri = URI.parse(src)
		http = Net::HTTP.start(@uri.host,@uri.port)
		request = Net::HTTP::Get.new("/adexchange/publisher/adUnit/listAll")
		response = http.request(request)
	 	@adunitsData = JSON.parse(response.body)
		http.finish
	end

	### Check if the campaign name already exists
	def checkCampaignName
		@sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
		@siteId=session[:site_id]
     src =  Tagaly3::SRC
      @uri = URI.parse(src)
      http = Net::HTTP.start(@uri.host,@uri.port)
			request = Net::HTTP::Get.new("/adexchange/advertiser/campaign/list/#{@siteId}")
      response = http.request(request)

       begin
      @CampData = JSON.parse(response.body)
      end
      contains="no"
      	@CampData.each do |key,camp|
      	 if camp["campaignName"]==params[:campaignName]
      	 	contains="yes"
      		end
      	end
      if contains=="yes"
      	render text: "yes"
			else
				render text: "no"
			end
	end
	## ad placemnets upload creatives
	
	def checkout
		@sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
	end
	
	def campaignsettings
		src =  Tagaly3::SRC
		@uri = URI.parse(src)
		http = Net::HTTP.new(@uri.host,@uri.port)
		@adIdscreated = Array.new
		if params[:campaign].present?
		$adunits=params[:adunits].split(/,/)
		#$ads=params[:ads]
		end
		if $adunits.present?
			@adunits=$adunits.split(/,/)
			@qty={}
				@adunits.each do |adunitId|
					name="qty_"+adunitId.to_s
					
					@qty.merge!(adunitId=> params[name])
					
				end

		end
		session[:imps]=@qty
		@sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
		@retargets = Retarget.where(siteId: session[:site_id])
    retargetsss=''
			exce = ""
     if @retargets.present?
		   exce = 'yes'
		   @retargets.each do |retarget|
				 exce = 'yes'
				 retargetsss = retargetsss + retarget.id.to_s + ","
		   end
     end
			@retargetsss = retargetsss
     if exce == 'yes'
		   src=Tagaly3::SRC + "/adexchange/trackAudience/list/#{session[:site_id]}/#{retargetsss}"
		   url = URI.parse(src)
		   req = Net::HTTP::Get.new(url.to_s)
		   res = Net::HTTP.start(url.host, url.port) {|http|
		   http.request(req)
		   }
		   resp=res.body
		   respcode=res.code
		   @retargetCount = JSON.parse(resp)
     #http.finish()
     end
     
     #### Get the host site script
     @result=''
			if session[:site_url] != nil
				
				  begin
				  @result = open("#{session[:site_url]}").read
				  rescue OpenURI::HTTPError
				  @failure =""
				  rescue SocketError
				  @failure =""
				  rescue Exception
				  @failure =""
				  else
				  @success =""
				  end
			else
				@result=''
			end
		src =  Tagaly3::SRC
      @uri = URI.parse(src)
      http = Net::HTTP.start(@uri.host,@uri.port)
      @siteId=session[:site_id]
		request = Net::HTTP::Get.new("/adexchange/advertiser/conversion/list/#{@siteId}")
    response = http.request(request)
    @code = response.code
    @conversionsList = JSON.parse(response.body)
	end
	
		#### Action to get minimum bid price
		def minBid
			src =  Tagaly3::SRC
			@uri = URI.parse(src)
			http = Net::HTTP.start(@uri.host,@uri.port)
			request = Net::HTTP::Post.new("/adexchange/advertiser/campaign/minBid")
			request.set_form_data({"advertiserId" => session[:user_id], "bidType" => params[:bidType],
				  "geoTargetingType" => params[:geoTargetingType] ,"geoTargeting" => params[:geoTargeting],
				  "devicePreference"=>params[:devicePreference], "dayParting"=> params[:dayparting]})
			response = http.request(request)
			http.finish
			render text: response.body
		end

end

class SparseArray
  attr_reader :hash
  def initialize
    @hash = {}
  end
  def [](key)
    hash[key] ||= {}
  end
  def rows
    hash.length   
  end
  alias_method :length, :rows
end
