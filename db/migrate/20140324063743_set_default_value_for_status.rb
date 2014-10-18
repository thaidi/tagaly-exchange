class SetDefaultValueForStatus < ActiveRecord::Migration
  def change
	execute "alter table publishersites alter column status set default 'Active'"
  end
end
