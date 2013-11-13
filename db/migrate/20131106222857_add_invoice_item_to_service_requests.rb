class AddInvoiceItemToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :invoice_item_id, :string
  end
end
