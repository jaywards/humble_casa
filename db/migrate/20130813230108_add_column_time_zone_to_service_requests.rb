class AddColumnTimeZoneToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :time_zone, :string
  end
end
