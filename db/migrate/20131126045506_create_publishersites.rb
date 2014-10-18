class CreatePublishersites < ActiveRecord::Migration
  def change
    create_table :publishersites do |t|
      t.string :website_title
      t.string :website_url
      t.text :description
      t.string :channel
      t.string :language
      t.string :avg_mon_imps
      t.string :csrftoken
       t.string :created_by

      t.timestamps
    end
  end
end
