class NativestylesController < ApplicationController
  layout 'createpublisher'
	def new
    @sites=Publishersite.where(created_by: session[:user_id] , status: 'Active')
	end
	def index
		if session[:user_id] == '' || session[:user_id] == nil
		  redirect_to '/login'
		else
			userId = session[:user_id]
		  @sites=Publishersite.where(created_by: session[:user_id] , status: 'Active')
			src =  Tagaly3::SRC
		  @uri = URI.parse(src)
		  http = Net::HTTP.start(@uri.host,@uri.port)
			request = Net::HTTP::Get.new("/adexchange/publisher/nativeStyle/list/#{userId}")
			response = http.request(request)
			@allNativestyles = JSON.parse(response.body)
		end
	end
end
