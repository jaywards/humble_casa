class AddColumnChargeToMasterServiceRequests < ActiveRecord::Migration
  add_column :master_service_requests, :charge, :decimal, precision: 5, scale: 2, default: 0
end
