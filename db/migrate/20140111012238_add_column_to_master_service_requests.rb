class AddColumnToMasterServiceRequests < ActiveRecord::Migration
  def change
    add_column :master_service_requests, :assignment_id, :integer
    add_column :service_requests, :assignment_id, :integer
  end
end
