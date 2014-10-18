class Site < ActiveRecord::Base
 attr_accessible :siteName, :siteUrl, :description ,:advertiserId, :siteStatus
  
  #attr_accessor :password
end
