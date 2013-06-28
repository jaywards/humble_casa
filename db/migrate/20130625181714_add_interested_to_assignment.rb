class AddInterestedToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :interested, :boolean
  end
end
