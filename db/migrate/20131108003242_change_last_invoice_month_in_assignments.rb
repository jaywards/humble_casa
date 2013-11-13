class ChangeLastInvoiceMonthInAssignments < ActiveRecord::Migration
  	remove_column :assignments, :last_invoice_month
	add_column :assignments, :last_invoice_date, :datetime
end
