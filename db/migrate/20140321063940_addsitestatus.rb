class Addsitestatus < ActiveRecord::Migration
  def change
  	add_column :sites, :siteStatus, :string
  end
end
