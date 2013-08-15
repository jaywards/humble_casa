class AddColumnAllScheduledToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :all_scheduled, :boolean
  end
end
