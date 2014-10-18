class AdunitsController < ApplicationController
  require 'net/http'
  layout 'createpublisher'
  active = 'Adunits'
	include CheckSiteIdHelper
  # Creating adunit.
	def adApproval
		if params[:adId].present? && params[:status].present?
			adId = params[:adId]
			status = params[:status]
			src =  Tagaly3::SRC
		  @uri = URI.parse(src)
		  http = Net::HTTP.new(@uri.host,@uri.port)
			request = Net::HTTP::Post.new("/adexchange/advertiser/advertisement/#{adId}")
			request.set_form_data({"approvalStatus"=>"#{status}"})
			response = http.request(request)
			@code = response.code
			@result = response.body
			if @result = ""
				render text: "success"
			else
				render text: "failed"
			end
		end
	end
	def startPlacement
		@sites =Publishersite.where(created_by: session[:user_id] , status: 'Active')
	end
	def updateStatus 
		@sites =Publishersite.where(created_by: session[:user_id] , status: 'Active')
		adunitId = params[:id]
		status = params[:status]
		if status == "Active" || status == "Pause" ||status == "Delete"
		  src =  Tagaly3::SRC
	    @uri = URI.parse(src)
	    http = Net::HTTP.new(@uri.host,@uri.port)
		  request = Net::HTTP::Post.new("/adexchange/publisher/adUnit/#{adunitId}")
			request.set_form_data({"status"=>"#{status}"})
		  response = http.request(request)
		  @code = response.code
		  @result = response.body
			if @code == 200 
				render text:"success"
			else
				render text:"failed"
			end
		end
	end
  def creatingadunits
		@sites =Publishersite.where(created_by: session[:user_id] , status: 'Active')
		@sitesCount = @sites.count
		if @sitesCount > 0
			publisherSiteId = session[:publishersite_id]
			@HOST_NAME = Tagaly3::HOST_NAME
			@host = Socket.gethostname
		  userId = session[:user_id]
		  src =  Tagaly3::SRC
		  if params[:adunit]
				bidType = "eCpm"
				price = ""
				if params[:adunit][:bidStrategy].present?
					price = params[:adunit][:bidStrategy]
				else
					price = params[:adunit][:bidStrategy]
				end
				if params[:adunit][:nativestyleid]
					nativeparams = params[:adunit][:nativestyleid].split("X")
					nstyleId = nativeparams[0]
					format = nativeparams[1]
				end
		    # Code to connect to API to add adunit from the form data
		    @uri = URI.parse(src)
		    http = Net::HTTP.new(@uri.host,@uri.port)
				placementsIds = params[:adunit][:placementId]
		    if params[:adunit][:alternate] == ""
		      @alternate="-"
		    else
		      @alternate=params[:adunit][:alternate]
		    end
				request = Net::HTTP::Get.new("/adexchange/publisher/adUnit/list/#{publisherSiteId}")
				response = http.request(request)
				@adunitsTotalData = JSON.parse(response.body)
#=begin
			breakadunit = 'false'
			if @adunitsTotalData.present?
				@adunitsTotalData.each do |key, value|
					if value["adUnitName"] == params[:adunit][:name]
							breakadunit = 'true'
							break
					end
				end
			end
#=end
		    request = Net::HTTP::Put.new("/adexchange/publisher/adUnit")
				if params[:adunit][:adtype] == "DisplayAd"
					request.set_form_data({"adUnitName" => params[:adunit][:name], "description" => params[:adunit][:description] , 
					"backupAdType" => params[:adunit][:backupadtype], "alternateUrl"=> @alternate, "fullBackground"=> params[:adunit][:fullbackground],
					"adType"=>params[:adunit][:adtype], "format"=> params[:adunit][:format], "placementId"=> params[:adunit][:placementId] , "status"=>"Active" ,
					"styleId"=> "123456790", "userId"=> userId ,"siteId"=> publisherSiteId , "bidType"=> bidType ,"price"=> price })
				elsif params[:adunit][:adtype] == "NativeAd"
					request.set_form_data({"adUnitName" => params[:adunit][:name], "description" => params[:adunit][:description] , 
					"backupAdType" => params[:adunit][:backupadtype], "alternateUrl"=> @alternate, "fullBackground"=> params[:adunit][:fullbackground] ,
					"adType"=>params[:adunit][:adtype], "styleId"=> nstyleId , "format"=> format , "price"=> price  , "status"=>"Active" ,
					 "userId"=> userId ,	"siteId"=> publisherSiteId 	, "bidType"=> bidType , "placementId"=> params[:adunit][:placementId]  })
				else
					request.set_form_data({"adUnitName" => params[:adunit][:name], "description" => params[:adunit][:description] , "status"=>"Active" ,
					"backupAdType" => params[:adunit][:backupadtype], "alternateUrl"=> @alternate, "fullBackground"=> params[:adunit][:fullbackground] ,
					"adType"=>params[:adunit][:adtype], "format"=> params[:adunit][:format], "price"=> price, "placementId"=> params[:adunit][:placementId]  , 
					"styleId"=> params[:adunit][:styleid], "userId"=> userId ,"siteId"=> publisherSiteId , "bidType"=> bidType })
				end
				if breakadunit == 'true'
					flash[:notice] = "Placement with #{params[:adunit][:name]} already exists;"
					redirect_to "/placements/creatingadunits"
				else
				  response = http.request(request)
				  @code = response.code
				  adunitId = response.body
				  # session[:adunitcode] = params[:adunit]
				  # '@code' holds the respose code.
				  if @code == '200'
						if params[:adunit][:adtype] == "NativeAd"
							if params[:adunit][:N_goto] == 'no'
								redirect_to "/placements/"
							else
								redirect_to "/placements/getcode?placementId=#{adunitId}"
							end
						else
							if params[:goto] == 'no'
								redirect_to "/placements/"
							else
								redirect_to "/placements/getcode?placementId=#{adunitId}"
							end
						end
					else
						redirect_to "/placements/new"
				  end
				end
		  else
		  	# Code to connect to API to get all styles for current user
			  @uri = URI.parse(src)
			  http = Net::HTTP.new(@uri.host,@uri.port)
			  request = Net::HTTP::Get.new("/adexchange/publisher/style/list/#{userId}")
			  response = http.request(request)
				# @otherstyles = response.body
			  @allstyles = JSON.parse(response.body)
			  # '@allstyles' holds the data of all the styles those created by user

		  	# Code to connect to API to get all styles for current user
			  @uri = URI.parse(src)
			  http = Net::HTTP.new(@uri.host,@uri.port)
			  request = Net::HTTP::Get.new("/adexchange/publisher/nativeStyle/list/#{userId}")
			  response = http.request(request)
				# @otherstyles = response.body
			  @allNativestyles = JSON.parse(response.body)
			  # '@allstyles' holds the data of all the styles those created by user

			  @style = Style.new
			  @Publishersites=Publishersite.where(created_by: session[:user_id] , status: 'Active')

				http = Net::HTTP.start(@uri.host,@uri.port)
			  request = Net::HTTP::Get.new("/adexchange/publisher/placement/list/#{publisherSiteId}")
				response = http.request(request)
				@placements = JSON.parse(response.body)

				request = Net::HTTP::Get.new("/adexchange/publisher/adUnit/list/#{publisherSiteId}")
				response = http.request(request)
				@adunitsTotalData = JSON.parse(response.body)
				@AdunitsCount = @adunitsTotalData.count + 1
			  http.finish
		  end
		else
		  #flash[:notice] = "Please add your site details before adding an ad placement."
		  redirect_to '/publishers/'
		end
  end
  
  def index
	  @sites=Publishersite.where(created_by: session[:user_id] , status: 'Active')
		@sitesCount = @sites.count
		if @sitesCount > 0
			userId = session[:user_id]
			@host = Socket.gethostname
		  publisherSiteId = session[:publishersite_id]
		  src =  Tagaly3::SRC
		  # Code to connect to API to get data of all th adunits add by current user.
		  @uri = URI.parse(src)
		  http = Net::HTTP.new(@uri.host,@uri.port)
		  request = Net::HTTP::Get.new("/adexchange/publisher/adUnit/list/#{publisherSiteId}")
		  response = http.request(request)
		  @adunitsData = JSON.parse(response.body)

		  requestForStyles = Net::HTTP::Get.new("/adexchange/publisher/style/list/#{userId}")
		  responseOfStyles = http.request(requestForStyles)
			# @otherstyles = response.body
		  @allstyles = JSON.parse(responseOfStyles.body)
		  # render text:"/adexchange/publisher/adUnit/list/#{publisherSiteId}"
		  # '@adunitsData' holds the data of all the adunits added by a user
		  if @adunitsData.present?				
		  	if @adunitsData.count == 0
					flash[:notice] = "Please add your placement."
					redirect_to "/placements/new"
				end
		  else
				flash[:notice] = "Please add your placement."
		    redirect_to "/placements/new"
		  end
		  @adunitsNativeAd =Adunit.where(user_id: session[:user_id],adtype: "NativeAd")
		else
		flash[:notice] = "Please"
		redirect_to '/publishers'
		end
  end

  def edit
    @sites = Publishersite.where(created_by: session[:user_id] , status: 'Active')
		if session[:publishersite_id]
		  userId = session[:user_id]
			publisherSiteId = session[:publishersite_id]
		  src =  Tagaly3::SRC
	    @uri = URI.parse(src)
	    http = Net::HTTP.start(@uri.host,@uri.port)
			adunitId = params[:id]
		  if params[:adunit]
				bidType = "eCpm"
				price = ""
				if params[:adunit][:bidStrategy].present?
					price = params[:adunit][:bidStrategy]
				else
					price = params[:adunit][:bidStrategy]
				end
				if params[:adunit][:nativestyleid]
					nativeparams = params[:adunit][:nativestyleid].split("X")
					nstyleId = nativeparams[0]
					format = nativeparams[1]
				end
		    # Code to connect to API to add adunit from the form data
		    @uri = URI.parse(src)
		    http = Net::HTTP.new(@uri.host,@uri.port)
				placementsIds = params[:adunit][:placementId]
		    if params[:adunit][:alternate] == ""
		      @alternate="-"
		    else
		      @alternate=params[:adunit][:alternate]
		    end
				request = Net::HTTP::Get.new("/adexchange/publisher/adUnit/list/#{publisherSiteId}")
				response = http.request(request)
				@adunitsTotalData = JSON.parse(response.body)
#=begin
			breakadunit = 'false'
			if @adunitsTotalData.present?
				@adunitsTotalData.each do |key, value|
					if value["adUnitName"] == params[:adunit][:name] && value["adUnitId"] != params[:id]
							breakadunit = 'true'
							break
					end
				end
			end
#=end
		  src =  Tagaly3::SRC
	    @uri = URI.parse(src)
	    http = Net::HTTP.start(@uri.host,@uri.port)
		    request = Net::HTTP::Post.new("/adexchange/publisher/adUnit/#{params[:id]}")
				if params[:adunit][:adtype] == "DisplayAd"
					request.set_form_data({"adUnitName" => params[:adunit][:name], "description" => params[:adunit][:description] , 
					"backupAdType" => params[:adunit][:backupadtype], "alternateUrl"=> @alternate, "fullBackground"=> params[:adunit][:fullbackground],
					"adType"=>params[:adunit][:adtype], "format"=> params[:adunit][:format], "placementId"=> params[:adunit][:placementId] , "status"=>"Active" ,
					"styleId"=> "123456790", "userId"=> userId ,"siteId"=> publisherSiteId , "bidType"=> bidType ,"price"=> price })
				elsif params[:adunit][:adtype] == "NativeAd"
					request.set_form_data({"adUnitName" => params[:adunit][:name], "description" => params[:adunit][:description] , 
					"backupAdType" => params[:adunit][:backupadtype], "alternateUrl"=> @alternate, "fullBackground"=> params[:adunit][:fullbackground] ,
					"adType"=>params[:adunit][:adtype], "styleId"=> nstyleId , "format"=> format , "price"=> price  , "status"=>"Active" ,
					 "userId"=> userId ,	"siteId"=> publisherSiteId 	, "bidType"=> bidType , "placementId"=> params[:adunit][:placementId]  })
				else
					request.set_form_data({"adUnitName" => params[:adunit][:name], "description" => params[:adunit][:description] , "status"=>"Active" ,
					"backupAdType" => params[:adunit][:backupadtype], "alternateUrl"=> @alternate, "fullBackground"=> params[:adunit][:fullbackground] ,
					"adType"=>params[:adunit][:adtype], "format"=> params[:adunit][:format], "price"=> price, "placementId"=> params[:adunit][:placementId]  , 
					"styleId"=> params[:adunit][:styleid], "userId"=> userId ,"siteId"=> publisherSiteId , "bidType"=> bidType })
				end
				if breakadunit == 'true'
					flash[:notice] = "Placement with #{params[:adunit][:name]} already exists;"
					redirect_to "/placements/creatingadunits"
				else
				  response = http.request(request)
				  @code = response.code
				  adunitId = response.body
				  # session[:adunitcode] = params[:adunit]
				  # '@code' holds the respose code.
				  if @code == '200'
							if params[:goto] == 'no'
								redirect_to "/placements/"
							else
								redirect_to "/placements/getcode?placementId=#{params[:id]}"
							end
					else
						redirect_to "/placements/new"
				  end
				end

			else

			  request = Net::HTTP::Get.new("/adexchange/publisher/nativeStyle/list/#{userId}")
			  response = http.request(request)
				# @otherstyles = response.body
			  @allNativestyles = JSON.parse(response.body)

			  stylesRequest = Net::HTTP::Get.new("/adexchange/publisher/style/list/#{userId}")
			  stylesResponse = http.request(stylesRequest)
			  @allstyles = JSON.parse(stylesResponse.body)
				
			  placementsRequest = Net::HTTP::Get.new("/adexchange/publisher/placement/list/#{publisherSiteId}")
				placementsResponse = http.request(placementsRequest)
				@placements = JSON.parse(placementsResponse.body)

				allAdunitsRequest = Net::HTTP::Get.new("/adexchange/publisher/adUnit/list/#{publisherSiteId}")
				allAdunitsResponse = http.request(allAdunitsRequest)
				@adunitsTotalData = JSON.parse(allAdunitsResponse.body)
				@AdunitsCount = @adunitsTotalData.count + 1


				adunitsRequest = Net::HTTP::Get.new("/adexchange/publisher/adUnit/#{adunitId}")
				adunitsResponse = http.request(adunitsRequest)
				@adunitData = JSON.parse(adunitsResponse.body)
				@returnValue = checkSiteId(@adunitData,'publisher')
				if @returnValue == false
					render_404
				end
			end
		else
		  #flash[:notice] = "Please add your site details before adding an ad placement."
		  redirect_to '/publishers/'
		end
  end

  def destroy   
			id = params[:id]
			@host = Socket.gethostname
			userId = session[:user_id]
			src =  Tagaly3::SRC
			# Code to connect with API
			@uri = URI.parse(src)
			http = Net::HTTP.new(@uri.host,@uri.port)
			request = Net::HTTP::Delete.new("/adexchange/publisher/adUnit/#{id}")
			response = http.request(request)
			redirect_to '/placements/'
  end

  def getcode
    @sites = Publishersite.where(created_by: session[:user_id] , status: 'Active')
    src =  Tagaly3::SRC
    	# Code to connect to API to get all styles for current user
    @uri = URI.parse(src)
    adUnitId = params[:placementId]
    http = Net::HTTP.new(@uri.host,@uri.port)

		adunitsRequest = Net::HTTP::Get.new("/adexchange/publisher/adUnit/#{adUnitId}")
		adunitsResponse = http.request(adunitsRequest)
		@adunitData = JSON.parse(adunitsResponse.body)
#=begin
		@returnValue = checkSiteId(@adunitData,'publisher')
		if @returnValue == false
			render_404
		else
			request = Net::HTTP::Get.new("/adexchange/publisher/adUnit/getAdunitCode/#{adUnitId}")
			response = http.request(request)
			@data = response.body
		end
#=end
  end

def show
    id = params[:id]
  	@host = Socket.gethostname
    userId = session[:user_id]
    src =  Tagaly3::SRC
    # Code to connect with API
    @uri = URI.parse(src)
    http = Net::HTTP.new(@uri.host,@uri.port)
    request = Net::HTTP::Delete.new("/adexchange/publisher/adUnit/#{id}")
    response = http.request(request)
    redirect_to '/adunits/'
end

def update
	@adunit = Adunit.find(params[:id])
	if @adunit.update_attributes(params[:adunit])
		flash[:notice] = 'Site was successfully updated.'
		redirect_to(adunits_path)
	else
		render "edit"
	end
end

	def newplacement
		@sites=Publishersite.where(created_by: session[:user_id] , status: 'Active')
		@sitesCount = @sites.count
		if @sitesCount > 0
			publisherSiteId = session[:publishersite_id]
			if params[:type] == "new"
				src =  Tagaly3::SRC
				# Code to connect with API
				@uri = URI.parse(src)
				http = Net::HTTP.start(@uri.host,@uri.port)
				if params[:placements]
					request = Net::HTTP::Put.new("/adexchange/publisher/placement")
					request.set_form_data({"placementName" => params[:placements][:name],"placementStatus" => "Active" , "publisherId" => session[:user_id], 				"siteId"=> publisherSiteId })
					response = http.request(request)
			 		redirect_to '/channels/viewall'
				else
					request = Net::HTTP::Get.new("/adexchange/publisher/placement/list/#{publisherSiteId}")
					response = http.request(request)
					@placementsBySiteId = JSON.parse(response.body)
				end
				http.finish
			elsif params[:type] == "edit"
				if params[:placements]
					placementId = params[:placementId]
					src =  Tagaly3::SRC
					# Code to connect with API
					@uri = URI.parse(src)
					http = Net::HTTP.start(@uri.host,@uri.port)
						request = Net::HTTP::Post.new("/adexchange/publisher/placement/#{placementId}")
						request.set_form_data({"placementName" => params[:placements][:name]})
					response = http.request(request)
					http.finish
			 		redirect_to '/channels/viewall'
				elsif 
					placementId = params[:placementId]
					src =  Tagaly3::SRC
					# Code to connect with API
					@uri = URI.parse(src)
					http = Net::HTTP.start(@uri.host,@uri.port)
					request = Net::HTTP::Get.new("/adexchange/publisher/placement/#{placementId}")
					response = http.request(request)
					@parsed = JSON.parse(response.body)
					@returnValue = checkSiteId(@parsed,'publisher')
					if @returnValue == false
						render_404
					end

					request = Net::HTTP::Get.new("/adexchange/publisher/placement/list/#{publisherSiteId}")
					response = http.request(request)
					@placementsBySiteId = JSON.parse(response.body)
					http.finish
				end
			elsif params[:type] == "viewall"
					src =  Tagaly3::SRC
					# Code to connect with API
					@uri = URI.parse(src)
					http = Net::HTTP.start(@uri.host,@uri.port)
					request = Net::HTTP::Get.new("/adexchange/publisher/placement/list/#{publisherSiteId}")
					response = http.request(request)
					@parsed = JSON.parse(response.body)
					if @parsed.present?				
						if @parsed.count == 0
							redirect_to "/channels/new"
						end
					else
						redirect_to "/channels/new"
					end
					http.finish
			elsif params[:type] == "destroy"
					placementId = params[:placementId]
					src =  Tagaly3::SRC
					@uri = URI.parse(src)
					http = Net::HTTP.start(@uri.host,@uri.port)
					request = Net::HTTP::Delete.new("/adexchange/publisher/placement/#{placementId}")
					response = http.request(request)
					http.finish
			 		redirect_to '/channels/viewall'
			end
		else
			$redirectTo = "/channels/new?aft=1"
			flash[:notice] = "Please"
			redirect_to '/publishers'
		end
	end
	
	def siteadunitslist
		publisherSiteId =params[:siteId]
		  src =  Tagaly3::SRC
		  @sites=Publishersite.where(created_by: session[:user_id] , status: 'Active')
		  # Code to connect to API to get data of all th adunits add by current user.
		  @uri = URI.parse(src)
		  http = Net::HTTP.new(@uri.host,@uri.port)
		  request = Net::HTTP::Get.new("/adexchange/publisher/adUnit/list/#{publisherSiteId}")
		  response = http.request(request)
		  @adunitsData = JSON.parse(response.body)
		  @adunitsDetails=""
		   @adunitsData.each do |key , adunit|
			if adunit['adType'] == 'DisplayAd' || adunit['adType'] == 'TextAndDisplayAd'
				@adunitsDetails=@adunitsDetails + key.to_s + "|" + adunit['adUnitName'].to_s + "|" + adunit['format'].to_s + "|" + adunit['price'].to_s + "|"
			end
		   end
		   render text: @adunitsDetails 
	end
	def orderapproval
		@sites=Publishersite.where(created_by: session[:user_id] , status: 'Active')
		@advSites = Site.where.not(id:0)
		publisherSiteId = session[:publishersite_id]

		$sitesDetails = SparseArray.new
		@advSites.each do |advSite|
			$sitesDetails[advSite.id]["name"] = advSite.siteName
			$sitesDetails[advSite.id]["url"] = advSite.siteUrl
		end
		if params[:type].present?
			if params[:type] == "Approved" || params[:type] == "Rejected" || params[:type] == "PendingApproval" || params[:type] == "All"
				@type = params[:type]
			else
				@type = "none"
			end
		else
				@type = "All"
		end
		if @type != "none"
			src =  Tagaly3::SRC
			@sites=Publishersite.where(created_by: session[:user_id] , status: 'Active')
			# Code to connect to API to get data of all th adunits add by current user.
			@uri = URI.parse(src)
			http = Net::HTTP.new(@uri.host,@uri.port)

			request = Net::HTTP::Get.new("/adexchange/publisher/site/#{publisherSiteId}/#{@type}")
			response = http.request(request)
			@adunitsData = JSON.parse(response.body)
			#render text: @adunitsData
		else
			
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
