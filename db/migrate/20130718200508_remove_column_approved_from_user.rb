class RemoveColumnApprovedFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :approved, :boolean
  end
end
