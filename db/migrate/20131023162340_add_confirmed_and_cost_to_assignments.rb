class AddConfirmedAndCostToAssignments < ActiveRecord::Migration
  def change
  	add_column :assignments, :confirmed, :boolean, default: false
  	add_column :assignments, :cost, :integer
  end
end
