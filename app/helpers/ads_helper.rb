module AdsHelper
require 'net/http'
  #### action to copy ad
  def copyAd(adId ="" ,version="",passedAdDetails="",adunitId ="")
		logger.debug "AdId came to Ads helper : #{adId} adunitId is #{adunitId}"
  	src =  Tagaly3::SRC
		@HOST_NAME = Tagaly3::HOST_NAME
		@host = Socket.gethostname
		@uri = URI.parse(src)
		http = Net::HTTP.new(@uri.host,@uri.port)
		request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/#{adId}")
		### Get Response
		response = http.request(request)
		@code = response.code
		@adDetails=JSON.parse(response.body)
		#@mergerarray@adDetails.zip(@version).flatten.compact
		
  	
  	#### Process the available ads to get the highest version for the ad
  	src =  Tagaly3::SRC
		@HOST_NAME = Tagaly3::HOST_NAME
		@host = Socket.gethostname
		@uri = URI.parse(src)
		http = Net::HTTP.new(@uri.host,@uri.port)
		request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/list/#{session[:user_id]}")
		### Get Response
		response = http.request(request)
		@code = response.code
		@adsList=JSON.parse(response.body)
  	@current_list = @adsList.select{|key,w| w['adName'] == @adDetails["adName"]}
  	blacklist = ["#{adId}"]
 		@sortedList=@current_list.sort_by{|key,e| -e["version"]}
 		@topVersion=@sortedList.first
  	
  	#### Create ad with the same details
  	@newVersion=@topVersion[1]["version"].to_f + 1
  	if passedAdDetails==""
			@adDetails["version"]=@newVersion.to_f
			#@del=@adDetails.delete("adId")
			####Removed tempararily
			#"devicePreference"=>@adDetails["devicePreference"],"bidType"=> @adDetails["bidType"] , "volume"=> @adDetails["volume"].to_i , "price"=> @adDetails["price"].to_f
			if adunitId == ""
			@addAdDetails={"advertiserId" => @adDetails["advertiserId"], "siteId" => @adDetails["siteId"],"adType" => @adDetails["adType"] ,"adName" => @adDetails["adName"],"adDestinationUrl"=>@adDetails["adDestinationUrl"], "adDisplayUrl"=> @adDetails["adDisplayUrl"],"adStatus"=>@adDetails["adStatus"],"adSize"=>@adDetails["adSize"], "adHeadline"=> @adDetails["adHeadline"], "adDescription"=> @adDetails["adDescription"], "adText"=> @adDetails["adText"],"utmParameters"=> @adDetails["utmParameters"], "adImageUrl"=> @adDetails["adImageUrl"] , "version"=> @adDetails["version"].to_f}
  		else
				@addAdDetails={ "adUnitId" => adunitId , "advertiserId" => @adDetails["advertiserId"], "siteId" => @adDetails["siteId"],"adType" => @adDetails["adType"] ,"adName" => @adDetails["adName"],"adDestinationUrl"=>@adDetails["adDestinationUrl"], "adDisplayUrl"=> @adDetails["adDisplayUrl"] , 	"adStatus"=>"PendingApproval" ,"adSize"=>@adDetails["adSize"], "adHeadline"=> @adDetails["adHeadline"], "adDescription"=> @adDetails["adDescription"], "adText"=> @adDetails["adText"],"utmParameters"=> @adDetails["utmParameters"], "adImageUrl"=> @adDetails["adImageUrl"] , "version"=> @adDetails["version"].to_f}
			end
			#@addAdDetails=@adDetails
  	else
  		passedAdDetails["version"]=@newVersion.to_f
			if adunitId != ""
  			passedAdDetails["adUnitId"] = adunitId
			end
			@addAdDetails=passedAdDetails
		end
  	src =  Tagaly3::SRC
		@HOST_NAME = Tagaly3::HOST_NAME
		@host = Socket.gethostname
		@uri = URI.parse(src)
		http = Net::HTTP.new(@uri.host,@uri.port)
		request = Net::HTTP::Put.new("/adexchange/advertiser/advertisement/")
		request.set_form_data(@addAdDetails)
		### Get Response
		response = http.request(request)
		
  	return response.body
  end
 end
