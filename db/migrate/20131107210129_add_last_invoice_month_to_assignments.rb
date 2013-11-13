class AddLastInvoiceMonthToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :last_invoice_month, :integer, default: 0
  end
end
