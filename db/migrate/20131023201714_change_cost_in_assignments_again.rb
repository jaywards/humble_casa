class ChangeCostInAssignmentsAgain < ActiveRecord::Migration
def change
		remove_column :assignments, :cost
		add_column :assignments, :cost, :decimal, precision: 5, scale: 2
	end
end
