class AddColumnScheduledToServiceRequest < ActiveRecord::Migration
  def change
    add_column :service_requests, :scheduled, :boolean, default: false
    add_column :service_requests, :scheduled_mailed, :boolean, default: false
  end
end
