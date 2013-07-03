class AddMasterServiceRequestIdToServiceRequest < ActiveRecord::Migration
  def change
    add_column :service_requests, :master_service_request_id, :integer
  end
end
