class CheckvalidurlController < ApplicationController
require 'net/http'
  def index
  cusUrl = params[:siteurl]
  begin
					uri = URI.parse(cusUrl)
			    http = Net::HTTP.new(uri.host, uri.port)
			    request = Net::HTTP::Get.new(uri.request_uri)
			    #This makes the request
			    resp = http.request(request)
			rescue SocketError => se
			else
			render text: resp.code
				if resp.code == "200" || resp.code == "302"
				end
			end
		end
end
