class UpdateStripeFieldsForServiceRequests < ActiveRecord::Migration
  def change
    remove_column :service_requests, :invoice_id
    add_column :service_requests, :charge_id, :string
  end
end
