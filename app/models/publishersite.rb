class Publishersite < ActiveRecord::Base
	attr_accessible :website_title, :website_url, :description, :channel ,:language ,:avg_mon_imps,:csrftoken,:created_by
end
