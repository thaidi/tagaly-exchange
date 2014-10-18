class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :sitename
      t.string :siteurl
      t.text :description
      t.string :user_type
      t.string :addedby

      t.timestamps
    end
  end
end
