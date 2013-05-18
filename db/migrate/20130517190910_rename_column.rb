class RenameColumn < ActiveRecord::Migration
def change
    change_table :work_assignments do |t|
      t.rename :employee_id, :user_id
      t.rename :request_id, :service_request_id
    end
  end
end
