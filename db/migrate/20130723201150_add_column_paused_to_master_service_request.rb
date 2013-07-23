class AddColumnPausedToMasterServiceRequest < ActiveRecord::Migration
  def change
    add_column :master_service_requests, :paused, :boolean
    add_column :service_requests, :paused, :boolean
  end
end
