class AddColumnActiveRequestIdToMasterServiceRequest < ActiveRecord::Migration
  def change
    add_column :master_service_requests, :active_request_id, :integer
  end
end
