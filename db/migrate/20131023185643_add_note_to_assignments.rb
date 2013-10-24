class AddNoteToAssignments < ActiveRecord::Migration
  def change
  	add_column :assignments, :note, :string
  end
end
