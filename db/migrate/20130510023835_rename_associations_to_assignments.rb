class RenameAssociationsToAssignments < ActiveRecord::Migration
  def up
  	rename_table :associations, :assignments
  end

  def down
  	rename_table :assignments, :associations
  end
end
