class AdRefAdunitsTable < ActiveRecord::Migration
  def change	
	remove_column :adunits, :user_id
	remove_column :adunits, :style_id
	add_reference :adunits, :user, index: true
	add_reference :adunits, :style, index: true
  end
end
