class ChangeStripeFieldsForServiceRequests < ActiveRecord::Migration
  def change
    remove_column :service_requests, :invoice_item_id
    add_column :service_requests, :invoice_id, :string
  end
end
