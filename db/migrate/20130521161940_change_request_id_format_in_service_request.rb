class ChangeRequestIdFormatInServiceRequest < ActiveRecord::Migration
  def change
    change_column :service_requests, :request_id, :string
  end
end

