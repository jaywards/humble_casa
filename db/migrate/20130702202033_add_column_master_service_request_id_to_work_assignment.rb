class AddColumnMasterServiceRequestIdToWorkAssignment < ActiveRecord::Migration
  def change
    add_column :work_assignments, :master_service_request_id, :integer
  end
end
