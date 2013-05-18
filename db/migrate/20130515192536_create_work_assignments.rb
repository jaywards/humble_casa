class CreateWorkAssignments < ActiveRecord::Migration
  def change
    create_table :work_assignments do |t|
      t.integer :user_id
      t.integer :service_request_id

      t.timestamps
    end
  end
end
