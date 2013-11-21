class AddInvoiceIdAndInvoiceDateToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :invoice_id, :string
    add_column :service_requests, :invoice_date, :datetime
  end
end
