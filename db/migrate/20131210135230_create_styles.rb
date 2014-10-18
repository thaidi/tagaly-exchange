class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.integer :userid
      t.string :usertype
      t.string :name
      t.string :border
      t.string :title
      t.string :background
      t.string :text
      t.string :url
      t.string :cornerstyle
      t.string :fontfamily
      t.string :fontsize

      t.timestamps
    end
  end
end
