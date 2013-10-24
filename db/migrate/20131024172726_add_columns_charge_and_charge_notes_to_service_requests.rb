class AddColumnsChargeAndChargeNotesToServiceRequests < ActiveRecord::Migration
  add_column :service_requests, :charge, :decimal, precision: 5, scale: 2, default: 0
  add_column :service_requests, :charge_notes, :string
end
