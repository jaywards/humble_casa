class AddColumnAllScheduledToMasterServiceRequests < ActiveRecord::Migration
  def change
    add_column :master_service_requests, :all_scheduled, :boolean
  end
end
