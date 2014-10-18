class AddStatusRetargets < ActiveRecord::Migration
  def change
		add_column :retargets, :status, :string
  end
end
