class Conversion < ActiveRecord::Base
   attr_accessible :conversionName, :revenue, :conversionType, :conversionValue,:conversionCounting,:advertiserId,:siteId
end
