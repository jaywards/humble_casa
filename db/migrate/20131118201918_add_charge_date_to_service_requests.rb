class AddChargeDateToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :charge_date, :datetime
  end
end
