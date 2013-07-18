class ChangeColumnApprovedInEmployment < ActiveRecord::Migration
  def change
    change_column :employments, :approved, :boolean, default: false
  end
end
