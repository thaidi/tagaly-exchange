class Retarget < ActiveRecord::Base
 attr_accessible :retargetName, :duration, :retargetType, :retargetValue, :advertiserId,:siteId,:version , :status
end
