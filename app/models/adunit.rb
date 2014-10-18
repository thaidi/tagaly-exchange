class Adunit < ActiveRecord::Base
	attr_accessible :name, :description, :backupadtype, :alternate, :fullbackground, :adtype, :devicetype, :format, :styleid, :keywordhint, :userid, :usertype
end
