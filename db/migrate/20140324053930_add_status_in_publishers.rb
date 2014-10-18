class AddStatusInPublishers < ActiveRecord::Migration
  def change
	add_column :publishersites, :status, :string
  end
end
