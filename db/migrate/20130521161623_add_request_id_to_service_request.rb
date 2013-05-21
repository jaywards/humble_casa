class AddRequestIdToServiceRequest < ActiveRecord::Migration
  def change
    add_column :service_requests, :request_id, :integer
  end
end
