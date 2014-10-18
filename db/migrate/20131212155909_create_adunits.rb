class CreateAdunits < ActiveRecord::Migration
  def change
    create_table :adunits do |t|
      t.string :name
      t.string :description
      t.string :backupadtype
      t.string :alternate
      t.string :fullbackground
      t.string :adtype
      t.string :devicetype
      t.string :format
      t.string :styleid
      t.string :keywordhint
      t.string :userid
      t.string :usertype

      t.timestamps
    end
  end
end
