class AddColumnsLocationVerifiedAndTimestampVerifiedToServiceRequest < ActiveRecord::Migration
  def change
    add_column :service_requests, :location_verified, :boolean
    add_column :service_requests, :timestamp_verified, :boolean
  end
end
