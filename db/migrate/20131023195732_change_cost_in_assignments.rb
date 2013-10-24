class ChangeCostInAssignments < ActiveRecord::Migration
def change
		remove_column :assignments, :cost
		add_column :assignments, :cost, :float
	end
end
