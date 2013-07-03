class AddColumnAllAssignedToMasterServiceRequest < ActiveRecord::Migration
  def change
    add_column :master_service_requests, :all_assigned, :boolean
  end
end
