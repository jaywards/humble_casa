class AddColumnInvoiceMeToServices < ActiveRecord::Migration
  def change
    add_column :services, :invoice_me, :boolean, default: false
  end
end
