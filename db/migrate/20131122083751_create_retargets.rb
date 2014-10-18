class CreateRetargets < ActiveRecord::Migration
  def change
    create_table :retargets do |t|
      t.string :listname
      t.string :duration
      t.string :retargeting_type
      t.string :path
      t.string :query
      t.string :event
      t.string :regex
      t.string :advertiseris
      t.string :siteid

      t.timestamps
    end
  end
end
