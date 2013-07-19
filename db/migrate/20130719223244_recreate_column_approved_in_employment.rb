class RecreateColumnApprovedInEmployment < ActiveRecord::Migration
  def change
    add_column :employments, :approved, :boolean
  end
end
