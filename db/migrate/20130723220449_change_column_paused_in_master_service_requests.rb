class ChangeColumnPausedInMasterServiceRequests < ActiveRecord::Migration
    def change
        change_column :master_service_requests, :paused, :boolean, default: false
    end
end
