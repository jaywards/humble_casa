class AddColumnDurationToMasterServiceRequests < ActiveRecord::Migration
  def change
    add_column :master_service_requests, :duration, :integer
  end
end
