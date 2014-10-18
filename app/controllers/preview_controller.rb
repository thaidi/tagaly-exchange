class PreviewController < ApplicationController
	layout :resolve_layout
	require 'net/http'
	require 'json'
	def getAllPlacementsBySiteId
	  src =  Tagaly3::SRC
	  @uri = URI.parse(src)
	  http = Net::HTTP.new(@uri.host,@uri.port)
	  @adUnitIds = Array.new
		if params[:campId].present?
			request = Net::HTTP::Get.new("/adexchange/advertiser/campaign/#{params[:campId]}")
			response = http.request(request)
			@campaignDetails = JSON.parse(response.body)
			@adUnitIds = @campaignDetails['adUnitId']
		end
		if params[:siteId].present? && params[:placementType].present?
			publisherSiteId = params[:siteId]
			placementType = params[:placementType]
		  request = Net::HTTP::Get.new("/adexchange/publisher/adUnit/list/#{publisherSiteId}")
		  response = http.request(request)
		  @adunitsData = JSON.parse(response.body)
		  @adunitsDetails = SparseArray.new
			preFinalString = ""
			if placementType == "native"
				@adunitsData.each do | key , adunit |
					if @adUnitIds.include? key.to_i
					else
						if adunit['adType'] == 'NativeAd'
							name = adunit["adUnitName"]
							format = adunit["format"]
							price = adunit["price"]
							string = "'#{key}':{'name':'#{name}','format':'#{format}','price':'#{price}'}"
							if preFinalString == ""
								preFinalString = string
							else
								preFinalString = "#{preFinalString},#{string}"
							end
						end
					end
				end
			elsif placementType == "display"
				@adunitsData.each do | key , adunit |
					if @adUnitIds.include? key.to_i
					else
						if adunit['adType'] == 'DisplayAd' || adunit['adType'] == 'TextAndDisplayAd'
							name = adunit["adUnitName"]
							format = adunit["format"]
							price = adunit["price"]
							string = "'#{key}':{'name':'#{name}','format':'#{format}','price':'#{price}'}"
							if preFinalString == ""
								preFinalString = string
							else
								preFinalString = "#{preFinalString},#{string}"
							end
						end
					end
				end
			end
			finalString = "{#{preFinalString}}"
		  render text: finalString
		end
	end
	def getsitesbychannels
		if params[:channelId].present? && params[:placementType].present? 
			channelId = params[:channelId]
			placementType = params[:placementType]
			if placementType == "display"
				session[:displayAdunitChannelId] = channelId
				@adunitsSites = session[:adunitsSites]
			elsif placementType == "native"
				session[:nativeAdunitChannelId] = channelId
				@adunitsSites = session[:nativeadunitsSites]
			end
			@allSiteDetailsForChannels = Publishersite.where("channel = '" + channelId +"' AND id in (?)" , @adunitsSites)
			@allallSiteDetailsForChannels = @allSiteDetailsForChannels.to_json
		end
	end
	def getsitesbychannelsedit
		@allallSiteDetailsForChannels = "{}"
		if params[:channelId].present? && params[:placementType].present? 
			channelId = params[:channelId]
			placementType = params[:placementType]
			if placementType == "display"
				session[:displayAdunitChannelId] = channelId
				@adunitsSites = session[:adunitsSitesEdit]
			elsif placementType == "native"
				session[:nativeAdunitChannelIdEdit] = channelId
				@adunitsSites = session[:adunitsSitesEdit]
			end
			@allSiteDetailsForChannels = Publishersite.where("channel = '" + channelId +"' AND id in (?)" , @adunitsSites)
			@allallSiteDetailsForChannels = @allSiteDetailsForChannels.to_json
		end
		render text: @allallSiteDetailsForChannels
	end
	def getsitesbychannelsn
		if params[:channelId].present?
			@sitesString =	session['nativeadunitsSites']
			channelId = params[:channelId]
			session[:nativeAdunitChannelId] = channelId
			#@allSiteDetailsForChannels = Publishersite.where(channel: channelId)
			@allSiteDetailsForChannels = Publishersite.where("channel = '" + channelId +"' AND id in (?)" , @sitesString)
			@allallSiteDetailsForChannels = @allSiteDetailsForChannels.to_json
		end
	end
	def jsonParseEdit
		@sites =Publishersite.where(created_by: session[:user_id] , status: 'Active')
		id = params[:id]
		src =  Tagaly3::SRC
		@uri = URI.parse(src)
		http = Net::HTTP.new(@uri.host,@uri.port)
		request = Net::HTTP::Get.new("/adexchange/publisher/nativeStyle/#{id}")
		response = http.request(request)
		@nativeAdStyle = JSON.parse(response.body)
		format = @nativeAdStyle["format"]
		@size = format.split(/x/)
		
		$styleData = SparseArray.new
		@nativeStyleData = JSON.parse(@nativeAdStyle["styleData"])
		@nativeStyleData.each do |key,value|
			value.each do |innerkey,innervalue|
				$styleData[key][innerkey] = innervalue
			end
		end
	end
	def getplacementsbysiteId
		if params[:siteId].present?
			publisherSiteId = params[:siteId]
		  src =  Tagaly3::SRC
		  @uri = URI.parse(src)
		  http = Net::HTTP.new(@uri.host,@uri.port)
		  request = Net::HTTP::Get.new("/adexchange/publisher/adUnit/list/#{publisherSiteId}")
		  response = http.request(request)
		  @adunitsData = JSON.parse(response.body)
		  @adunitsDetails = ""
		  @adunitsData.each do |key , adunit|
				if adunit['adType'] == 'NativeAd'
					@adunitsDetails=@adunitsDetails + key.to_s + "|" + adunit['adUnitName'].to_s + "|" + adunit['format'].to_s + "|" + adunit['price'].to_s + "|"
				end
		  end
		   render text: @adunitsDetails 
=begin
			publisherSiteId = params[:siteId]
			src =  Tagaly3::SRC
		  @uri = URI.parse(src)
		  http = Net::HTTP.new(@uri.host,@uri.port)
			request = Net::HTTP::Get.new("/adexchange/publisher/adUnit/list/#{publisherSiteId}")
			response = http.request(request)
			@adunitsTotalData = response.body
=end
		end
	end
	def jsonParse
		@fonts = Font.where(publisherid: session[:user_id])
		@sites =Publishersite.where(created_by: session[:user_id] , status: 'Active')
		image = authorimage = caretimage = facebooklike = facebookshare = gplusshare = linkedInshare = twittershare = youtubesnapshot = videosnapshot = ""
    ctime=Time.now().to_i
		if params[:upload].present?
		  if params[:upload][:image]
		    image = ctime.to_s + params[:upload][:image].original_filename
				params[:upload]['datafile'] = params[:upload][:image]
		    post = DataFile.save(params[:upload],ctime)
		  end
		  if params[:upload][:authorimage]
		    authorimage = ctime.to_s + params[:upload][:authorimage].original_filename
				params[:upload]['datafile'] = params[:upload][:authorimage]
		    post = DataFile.save(params[:upload],ctime)
		  end
		  if params[:upload][:caretimage]
		    caretimage = ctime.to_s + params[:upload][:caretimage].original_filename
				params[:upload]['datafile'] = params[:upload][:caretimage]
		    post = DataFile.save(params[:upload],ctime)
		  end
		  if params[:upload][:facebooklike]
		    facebooklike = ctime.to_s + params[:upload][:facebooklike].original_filename
				params[:upload]['datafile'] = params[:upload][:facebooklike]
		    post = DataFile.save(params[:upload],ctime)
		  end
		  if params[:upload][:facebookshare]
		    facebookshare = ctime.to_s + params[:upload][:facebookshare].original_filename
				params[:upload]['datafile'] = params[:upload][:facebookshare]
		    post = DataFile.save(params[:upload],ctime)
		  end
		  if params[:upload][:gplusshare]
		    gplusshare = ctime.to_s + params[:upload][:gplusshare].original_filename
				params[:upload]['datafile'] = params[:upload][:gplusshare]
		    post = DataFile.save(params[:upload],ctime)
		  end
		  if params[:upload][:linkedInshare]
		    linkedInshare = ctime.to_s + params[:upload][:linkedInshare].original_filename
				params[:upload]['datafile'] = params[:upload][:linkedInshare]
		    post = DataFile.save(params[:upload],ctime)
		  end
		  if params[:upload][:twittershare]
		    twittershare = ctime.to_s + params[:upload][:twittershare].original_filename
				params[:upload]['datafile'] = params[:upload][:twittershare]
		    post = DataFile.save(params[:upload],ctime)
		  end
		  if params[:upload][:youtubesnapshot]
		    youtubesnapshot = ctime.to_s + params[:upload][:youtubesnapshot].original_filename
				params[:upload]['datafile'] = params[:upload][:youtubesnapshot]
		    post = DataFile.save(params[:upload],ctime)
		  end
		  if params[:upload][:videosnapshot]
		    videosnapshot = ctime.to_s + params[:upload][:videosnapshot].original_filename
				params[:upload]['datafile'] = params[:upload][:videosnapshot]
		    post = DataFile.save(params[:upload],ctime)
		  end
		end
		if params[:placements]
			@params = params[:placements]
			@finalValue = Hash.new(Array.new)
			@finalValue[:userId] = "qwe"
			styleData = ''
			innerStyleData = ''
			j = 0
			params[:placements][:styleData].each do |key,elements|
				i = 0
				innerStyleData = ''
				elements.each do |keyofkey,elementofelement|
					if i == 0
						innerStyleData += "'#{keyofkey}':'#{elementofelement}'"
					else
						innerStyleData += ", '#{keyofkey}':'#{elementofelement}'"
					end
					i += 1
				end
				if key == "linAdunitsimage"
					innerStyleData += " , 'imageSrc' : '#{image}'"
				elsif key == "linAdunitsauthorimage"
					innerStyleData += " , 'imageSrc' : '#{authorimage}'"
				elsif key == "linAdunitscaret"
					innerStyleData += " , 'imageSrc' : '#{caretimage}'"
				elsif key == "linAdunitsyoutubesnapshot"
					innerStyleData += " , 'imageSrc' : '#{youtubesnapshot}'"
				elsif key == "linAdunitsvideosnapshot"
					innerStyleData += " , 'imageSrc' : '#{videosnapshot}'"
				elsif key == "linAdunitsfacebooklikeoranysocialmediawidget"
					innerStyleData += " , 'imageSrc' : '#{facebooklike}'"
				elsif key == "linAdunitsfacebookshare"
					innerStyleData += " , 'imageSrc' : '#{facebookshare}'"
				elsif key == "linAdunitsgoogleplusshare"
					innerStyleData += " , 'imageSrc' : '#{gplusshare}'"
				elsif key == "linAdunitslinkedinshare"
					innerStyleData += " , 'imageSrc' : '#{linkedInshare}'"
				elsif key == "linAdunitstwittershare"
					innerStyleData += " , 'imageSrc' : '#{twittershare}'"
				end
				if j == 0
					styleData += "'#{key}' : { #{innerStyleData} }"
				else
					styleData += ", '#{key}' : { #{innerStyleData} }"
				end
				j += 1
			end
			@styleData = styleData = "'styleData':{" + styleData + "}"
			@finalString = "{'userId':'#{session[:user_id]}' , 'styleName':'#{params[:placements][:stylename]}' , 'canvasStyle': '#{params[:placements][:canvasStyles]}' , 'format': '#{params[:placements][:format]}' , "
			@finalString = @finalString + @styleData + " }"
#=begin
			src =  Tagaly3::SRC
			@uri = URI.parse(src)
			http = Net::HTTP.new(@uri.host,@uri.port)
			request = Net::HTTP::Put.new("/adexchange/publisher/nativeStyle" , {'Content-Type' =>'application/json'})
			jsonv = @finalString
			request.body = jsonv
			response = http.request(request)
			@code = response.code
			@body = response.body
			if @body.present?
				redirect_to '/nativestyles/'
			end
#=end
		end
#=end
	end

	def previewForAdDisplay
		
	end
	def nativeStyleDisplay
		@fontDetails = Font.where(publisherid: session[:user_id])
		id = params[:id]
		src =  Tagaly3::SRC
		@uri = URI.parse(src)
		http = Net::HTTP.new(@uri.host,@uri.port)
		request = Net::HTTP::Get.new("/adexchange/publisher/nativeStyle/#{id}")
		response = http.request(request)
		@nativeAdStyle = JSON.parse(response.body)
	end
	def testUrl
		@url = cusUrl = params[:url]
		begin
	    uri = URI.parse(cusUrl)
	    http = Net::HTTP.new(uri.host, uri.port)
	    if cusUrl =~ /^https/
		  	http.use_ssl = true
				http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			end
			request = Net::HTTP::Get.new(uri.request_uri)
	    @resp = http.request(request)
			rescue URI::InvalidURIError => se
				render text: "BadURL"			
			rescue SocketError => se
				render text: "BadURL"
			rescue Errno::ETIMEDOUT => se
				render text: "BadURL"
			rescue Errno::ECONNREFUSED=>se
				render text: "BadURL"
			rescue Errno::ECONNRESET => se
				render text: "NotBad"
			else
				render text: "Good"
		end
	end
  def index
    if params[:styleId]
			@id = id = params[:styleId]
			src =  Tagaly3::SRC
			@uri = URI.parse(src)
			http = Net::HTTP.start(@uri.host,@uri.port)
			request = Net::HTTP::Get.new("/adexchange/publisher/style/#{id}")
			response = http.request(request)
			@styleDetails = JSON.parse(response.body)
			http.finish
    end
  end
	def styleoptions
			id = session[:user_id]
			src =  Tagaly3::SRC
			@uri = URI.parse(src)
			http = Net::HTTP.start(@uri.host,@uri.port)
			request = Net::HTTP::Get.new("/adexchange/publisher/style/list/#{id}")
			response = http.request(request)
			@allstyles = JSON.parse(response.body)
			http.finish
		render 'styleoptions' , :layout => false
	end
  def setdates
  end
	def totalstats
		
	end
	def changeplacementstatus
 		# redirect_to '/placements/viewall'
	end
	def addplacement
		publisherSiteId = session[:publishersite_id]
		userId = session[:user_id]
		if params[:placementname]
			placementname = params[:placementname]
		  src =  Tagaly3::SRC
		  # Code to connect with API
		  @uri = URI.parse(src)
		  http = Net::HTTP.start(@uri.host,@uri.port)
	    request = Net::HTTP::Put.new("/adexchange/publisher/placement")
	    request.set_form_data({"placementName" => placementname, "placementStatus" => "Active", "publisherId" => userId, "siteId"=> publisherSiteId})
		  response = http.request(request)
	    http.finish
		end
		if params[:placementId]
			placementId = params[:placementId]
			src =  Tagaly3::SRC
			# Code to connect with API
			@uri = URI.parse(src)
			http = Net::HTTP.start(@uri.host,@uri.port)
				request = Net::HTTP::Post.new("/adexchange/publisher/placement/#{placementId}")
				request.set_form_data({"placementStatus" => params[:placementStatus]})
			response = http.request(request)
			http.finish
		end
	end
	def publishergraph
		publisherId = session[:user_id]
		reportType = params[:id]
    if !session[:startdate] and !session[:enddate] and !session[:value]
      session[:startdate] = Date.today - 7.days
      session[:enddate] = Date.today
      session[:datetype] = "5"
    end
		siteId = session[:publishersite_id]
		usrtimeZone = Rack::Utils.escape(session[:user_timezone])
		startdate = session[:startdate].to_s + "%2000:00:00"
		enddate = session[:enddate].to_s + "%2023:59:59"
		src =  Tagaly3::SRC
    @uri = URI.parse(src)
    http = Net::HTTP.start(@uri.host,@uri.port)
    request = Net::HTTP::Get.new("/adexchange/publisher/dashboard/graph/siteId/#{siteId}/#{usrtimeZone}/#{startdate}/#{enddate}")
  	response = http.request(request)
		@graphDataForCamp = JSON.parse(response.body)
		# render text: "/adexchange/publisher/dashboard/graph/siteId/#{siteId}/#{usrtimeZone}/#{startdate}/#{enddate}"
    http.finish
	end
	def addstyles
			src =  Tagaly3::SRC
      @uri = URI.parse(src)
      http = Net::HTTP.start(@uri.host,@uri.port)
      request = Net::HTTP::Put.new("/adexchange/publisher/style")
@somevar = { "name" => params[:stylename],
       "border" => params[:styleborder] ,"title" => params[:styletitle],
       "background"=>params[:stylebackground], "text"=> params[:styletext], 
       "url"=>params[:styleurl], "cornerStyle"=> params[:stylecorner],
       "userId"=> session[:user_id], "fontFamily"=> params[:stylefontfamily] }

      request.set_form_data({"name" => params[:stylename],
       "border" => params[:styleborder] ,"title" => params[:styletitle],
       "background"=>params[:stylebackground], "text"=> params[:styletext], 
       "url"=>params[:styleurl], "cornerStyle"=> params[:stylecorner],
       "userId"=> session[:user_id], "fontFamily"=> params[:stylefontfamily] })
 			 	response = http.request(request)
   			http.finish
	end
	
  def graph
     if session[:user_timezone] != nil
       @timezone=session[:user_timezone].dup
     else
       @timezone='UTC'
     end
     @timezone=@timezone.sub! '/', '%2F'
     @siteId=session[:site_id]
    src =  Tagaly3::SRC
    @uri = URI.parse(src)
    http =Net::HTTP.start(@uri.host,@uri.port)
		if session[:dashboardGraphType] == "Campaigns"
			request = Net::HTTP::Get.new("/adexchange/advertiser/campaign/dashboard/graph/siteId/#{@siteId}/#{session[:dashboardGraphStatus]}/#{@timezone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}")
		logger.debug "Ad Exchane Url /adexchange/advertiser/campaign/dashboard/graph/siteId/#{@siteId}/#{session[:dashboardGraphStatus]}/#{@timezone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}"
		elsif session[:dashboardGraphType] == "Ads"
			request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/dashboard/graph/siteId/#{@siteId}/#{session[:dashboardGraphStatus]}/#{$campstatus}/#{@timezone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}")
			logger.debug "/adexchange/advertiser/advertisement/dashboard/graph/siteId/#{@siteId}/#{session[:dashboardGraphStatus]}/#{$campstatus}/#{@timezone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}"
		elsif session[:dashboardGraphType] == "Conversions"
			request = Net::HTTP::Get.new("/adexchange/advertiser/conversion/dashboard/graph/siteId/#{@siteId}/Assigned/#{@timezone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}")
			logger.debug "/adexchange/advertiser/conversion/dashboard/graph/siteId/#{@siteId}/Assigned/#{@timezone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}"
		elsif session[:dashboardGraphType] == "Domains"
			request = Net::HTTP::Get.new("/adexchange/advertiser/domains/dashboard/graph/siteId/#{@siteId}/All/#{@timezone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}")
			logger.debug "/adexchange/advertiser/domains/dashboard/graph/siteId/#{@siteId}/All/#{@timezone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}"
		end
    response = http.request(request)
    
    #render text: response.body
		@graphDataForCamp1 = response.body
		#render text: @graphDataForCamp1
    @graphDataForCamp = JSON.parse(response.body)
    http.finish
    #  session[:user_timezone]=@timezone.sub! '%2F','/'

    #render text: @graphDataForCamp.inspect
    if params[:exportType]=="byday"
      headings = ['Date','Total Conversions Per Click','Total Impressions','Total Cost','Total Conversions','Total Views Through Conversions','Total Clicks','Total Average Position']
      column_names = headings
      s=CSV.generate do |csv|
				csv << column_names
			end
			totConvsManyPerClick = 0
			totImpressions = 0
			totCost = 0
			totConversions = 0
			totViewThroughConversions = 0
			totClicks = 0
			totAveragePosition = 0
			@graphDataForCamp.each do |data|
				data.each do |key,byday|
					totConvsManyPerClick = totConvsManyPerClick + byday["totConversionsManyPerClick"].to_i
					totImpressions = totImpressions + byday["totImpressions"].to_i
					totCost = totCost + byday["totCost"].to_i
					totConversions = totConversions + byday["totConversions"].to_i
					totViewThroughConversions = totViewThroughConversions + byday["totViewThroughConversions"].to_i
					totClicks = totClicks + byday["totClicks"].to_i
					totAveragePosition = totAveragePosition + byday["totAveragePosition"].to_i
					date = DateTime.parse(key)
					hashes=[date.strftime("%m-%d-%Y"),byday["totConversionsManyPerClick"],byday["totImpressions"],byday["totCost"],byday["totConversions"],byday["totViewThroughConversions"],byday["totClicks"],byday["totAveragePosition"]]
					s = s + CSV.generate do |csv|
						csv << hashes
					end
				end
			end
			hashes=["Totals",totConvsManyPerClick,totImpressions,totCost,totConversions,totViewThroughConversions,totClicks,totAveragePosition]
			s = s + CSV.generate do |csv|
			  csv << hashes
			end
   	 	send_data s, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment;filename=byday.csv"
      #render 'byday.csv'
    end
  end
  
  def editor
  end

  private

  def resolve_layout
    case action_name
    when "jsonParse" , "jsonParseEdit"
      "nativeAdunitsLayout"
    else
      "nill"
    end
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
