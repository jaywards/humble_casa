class AddColumnTimeZoneToMasterServiceRequests < ActiveRecord::Migration
  def change
    add_column :master_service_requests, :time_zone, :string
  end
end
