class DropRolesAndAssigmentsTables < ActiveRecord::Migration
  def up
  	drop_table :roles
  	drop_table :assignments
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
