class AddColumnAssignableToWorkAssignment < ActiveRecord::Migration
  def change
  	add_column :work_assignments, :assignable_id, :integer
  	add_column :work_assignments, :assignable_type, :string
  end
end
