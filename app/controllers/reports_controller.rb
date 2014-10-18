class ReportsController < ApplicationController
  layout 'createpublisher'
  def index
    @sites = Publishersite.where(created_by: session[:user_id] , status: 'Active')
		usrtimeZone = Rack::Utils.escape(session[:user_timezone])
		publisherId = session[:user_id]
		reportType = params[:id]
		if params[:exportType]
			exportType = params[:exportType]
		end
		rTypes = [ "adUnit", "adSize", "adType", "siteId", "countries", "deviceType" ]
		if rTypes.include?(reportType)
			puts 'Found it in the array'
		else
			redirect_to "/reports/publisher/adUnit"
		end
    if !session[:startdate] and !session[:enddate] and !session[:value]
      session[:startdate] = Date.today - 7.days
      session[:enddate] = Date.today
      session[:datetype] = "5"
    end
		siteId = session[:publishersite_id]
		startdate = session[:startdate].to_s + "%2000:00:00"
		enddate = session[:enddate].to_s + "%2023:59:59"
		@sitesCount = @sites.count
		if @sitesCount > 0
			src =  Tagaly3::SRC
		  @uri = URI.parse(src)
		  http = Net::HTTP.start(@uri.host,@uri.port)
		  request = Net::HTTP::Get.new("/adexchange/publisher/dashboard/siteId/#{siteId}/#{reportType}/#{usrtimeZone}/#{startdate}/#{enddate}")
			response = http.request(request)
			begin
			@adunitsData = JSON.parse(response.body)
			rescue JSON::ParserError => pe
			
			else

			end
		  http.finish
			if params[:id] == 'adUnit'
				name = "Ad unit Name"
			elsif params[:id] == 'adSize'
				name = "Ad Size"
			elsif params[:id] == 'adType'
				name = "Ad Size"
			elsif params[:id] == 'siteId'
				name = "Site Name"
			elsif params[:id] == 'countries'
				name = "Countries"
			elsif params[:id] == 'deviceType'
				name = "Device Type"

				
			end
			if params[:exportType] == "export"
				headings=[ name ,'Impr.','Clicks','CTR','CPM','CPC','CPA','Conv.','Cost']
				csvFileData = CSV.generate do |csv|
					csv << headings
				end
				if @adunitsData.present?
					@adunitsData['type'].each do |key,ads|
						if params[:id] == 'siteId'
							keyv = session[:publishersite_name]
						else
							keyv = key
						end
						hashes=[{ name => keyv, 'Impr.'=>@adunitsData['type'][key]["totImpressions"], 'Clicks'=>@adunitsData['type'][key]["totClicks"], 'CTR'=>@adunitsData['type'][key]["totCTR"], 'CPM'=>@adunitsData['type'][key]["totCPM"], 'CPC'=>@adunitsData['type'][key]["totCPC"], 'CPA'=>@adunitsData['type'][key]["totCPA"], 'Conv.'=>@adunitsData['type'][key]["totConversions"], 'Cost'=> @adunitsData['type'][key]["totCost"]}]
						csvFileData = csvFileData + CSV.generate do |csv|
							hashes.each do |x|
								csv << x.values
							end
						end
					end
					hashes=[{name => "Totals", 'Impr.'=>@adunitsData['totals']["totImpressions"], 'Clicks'=>@adunitsData['totals']["totClicks"], 'CTR'=>@adunitsData['totals']["totCTR"], 'CPM'=>@adunitsData['totals']["totCPM"], 'CPC'=>@adunitsData['totals']["totCPC"], 'CPA'=>@adunitsData['totals']["totCPA"], 'Conv.'=>@adunitsData['totals']["totConversions"], 'Cost'=> @adunitsData['totals']["totCost"]}]
						csvFileData = csvFileData + CSV.generate do |csv|
							hashes.each do |x|
								csv << x.values
							end
						end
				end
				filename = "attachment;filename=" + params[:id] +".csv"
				send_data csvFileData, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => filename
			end
		else
			$redirectTo = "/reports/publisher/#{params[:id]}?aft=1"
		  flash[:notice] = "Please add your site details."
		  redirect_to '/publishers'
  	end
	end
end
