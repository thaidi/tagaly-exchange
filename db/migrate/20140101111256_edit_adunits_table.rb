class EditAdunitsTable < ActiveRecord::Migration
  def change
	rename_column :adunits, :userid, :user_id
	rename_column :adunits, :styleid, :style_id
	rename_column :adunits, :name, :adUnitName
	rename_column :adunits, :alternate, :alternateUrl
	remove_column :adunits, :keywordhint
	#change_column :adunits, :user_id, :integer
	#change_column :adunits, :style_id, :integer
  end
end
