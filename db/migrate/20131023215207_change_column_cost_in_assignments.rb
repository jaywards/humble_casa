class ChangeColumnCostInAssignments < ActiveRecord::Migration
		remove_column :assignments, :cost
		add_column :assignments, :cost, :decimal, precision: 5, scale: 2, default: 0
end
