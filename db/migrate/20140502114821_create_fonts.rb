class CreateFonts < ActiveRecord::Migration
  def change
=begin    
    create_table :fonts do |t|
      t.string :name, limit: 20
      t.string :url
      t.integer :publisherid

      t.timestamps
    end
=end
  end
end
