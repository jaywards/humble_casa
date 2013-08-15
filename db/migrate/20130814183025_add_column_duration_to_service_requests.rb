class AddColumnDurationToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :duration, :integer
  end
end
