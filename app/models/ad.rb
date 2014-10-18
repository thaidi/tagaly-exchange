class Ad < ActiveRecord::Base
  attr_accessible :ad_name,:image,:destination_url,:ad_type,:headline,:text,:site_id
end
