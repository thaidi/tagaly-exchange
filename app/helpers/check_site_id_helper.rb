module CheckSiteIdHelper
	def checkSiteId(parsedArray,sessionType)
		if sessionType == 'advertiser'
			siteId = session[:site_id]
		else
			siteId = session[:publishersite_id]
		end
		if parsedArray['siteId'] == siteId
			return true
		else
			return false
		end
	end
end
