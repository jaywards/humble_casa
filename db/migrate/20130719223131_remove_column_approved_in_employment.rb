class RemoveColumnApprovedInEmployment < ActiveRecord::Migration
  def change
    remove_column :employments, :approved, :boolean
  end
end
