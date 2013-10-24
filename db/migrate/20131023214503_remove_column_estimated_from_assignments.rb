class RemoveColumnEstimatedFromAssignments < ActiveRecord::Migration
  remove_column :assignments, :estimated
end
