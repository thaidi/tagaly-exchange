class PublishersController < ApplicationController
  layout 'nativeAdunitsLayout'
  require 'net/http'
	def introduction
  	@sites = Publishersite.where(created_by: session[:user_id] , status: 'Active')
	end
  def index
		if session[:user_id] == '' || session[:user_id] == nil
		  redirect_to '/login'
		else
			begin
				sitDetails = Publishersite.where(created_by: session[:user_id] , id: params[:siteId])
				rescue ActiveRecord::RecordNotFound
				render_404
			else
				if sitDetails.present?
					sitDetails.each do |site|
						if site['status'] == "Active"
							session[:publishersite_name] = site.website_title
							session[:publishersite_id] = site.id
							session[:publishersite_url] = site.website_url
						else
							flash[:notice] = "Please activate the site or Please select only active sites."
							redirect_to '/publishers/'
						end
					end
					usrtimeZone = Rack::Utils.escape(session[:user_timezone])
					@sites = Publishersite.where(created_by: session[:user_id] , status: 'Active')
					today = Date.today
					yest = Date.today - 1.days
					sameDayLastWeek = Date.today - 7.days
					thisMonthFirst = Date.today.at_beginning_of_month
					lastMonthFirst = Date.today.at_beginning_of_month.last_month
					lastMonthThisDay = Date.today.at_beginning_of_month.last_month + (today.strftime("%d").to_i - 1).days
						lastMonthLast = Date.today.at_end_of_month.last_month
					beforeMonthFirst = Date.today.at_beginning_of_month.last_month.last_month
					beforeMonthLast = Date.today.at_end_of_month.last_month.last_month
					# myappone.com:9090/adexchange/publisher/dashboard/12/UTC/2014-01-10 00:00:00/2014-01-31 23:59:59
					if params[:siteId].present?
						siteId = params[:siteId]
						userId = session[:user_id]
						src =  Tagaly3::SRC
						@uri = URI.parse(src)
						http = Net::HTTP.start(@uri.host,@uri.port)
						request = Net::HTTP::Get.new("/adexchange/publisher/dashboard/siteId/#{siteId}/#{usrtimeZone}/#{today}%2000:00:00/#{today}%2023:59:59")
						response = http.request(request)
						@dataForToday = JSON.parse(response.body)

						request = Net::HTTP::Get.new("/adexchange/publisher/dashboard/siteId/#{siteId}/#{usrtimeZone}/#{yest}%2000:00:00/#{yest}%2023:59:59")
						response = http.request(request)
						@dataForYest = JSON.parse(response.body)

						request = Net::HTTP::Get.new("/adexchange/publisher/dashboard/siteId/#{siteId}/#{usrtimeZone}/#{sameDayLastWeek}%2000:00:00/#{sameDayLastWeek}%2023:59:59")
						response = http.request(request)
						@dataForSameDayLastWeek = JSON.parse(response.body)

						request = Net::HTTP::Get.new("/adexchange/publisher/dashboard/siteId/#{siteId}/#{usrtimeZone}/#{thisMonthFirst}%2000:00:00/#{today}%2023:59:59")
						response = http.request(request)
						@dataForThisMonth = JSON.parse(response.body)

						request = Net::HTTP::Get.new("/adexchange/publisher/dashboard/siteId/#{siteId}/#{usrtimeZone}/#{lastMonthFirst}%2000:00:00/#{lastMonthThisDay}%2023:59:59")
						response = http.request(request)
						@dataForLastMonthSameDay = JSON.parse(response.body)

						request = Net::HTTP::Get.new("/adexchange/publisher/dashboard/siteId/#{siteId}/#{usrtimeZone}/#{lastMonthFirst}%2000:00:00/#{lastMonthLast}%2023:59:59")
						response = http.request(request)
						@dataForLastMonth = JSON.parse(response.body)

						request = Net::HTTP::Get.new("/adexchange/publisher/dashboard/siteId/#{siteId}/#{usrtimeZone}/#{beforeMonthFirst}%2000:00:00/#{beforeMonthLast}%2023:59:59")
						response = http.request(request)
						@dataForBeforeMonth = JSON.parse(response.body)
						http.finish
					else
						if session[:publishersite_id] != nil && session[:publishersite_id] != ''
							redirect_to "/publishers/dashboard/#{session[:publishersite_id]}"
						else
							#flash[:notice] = "Please add your site details."
							redirect_to '/publishers/introduction'
						end
					end
				else
					redirect_to '/publishers/introduction'
					#render_404
				end
			end
  	end
	end
	def setsessions
		@sitese=Publishersite.where(id: params[:id])
		@sitese.each do |sitei|
			session[:publishersite_name] = sitei.website_title
			session[:publishersite_id] = sitei.id
			session[:publishersite_url] = sitei.website_url
		end
		redirect_to request.env["HTTP_REFERER"]
	end
	def show
		@site = Site.find(params[:id])
	end
end
