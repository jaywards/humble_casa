class AddColumnEstimatedToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :estimated, :boolean, default: false
  end
end
