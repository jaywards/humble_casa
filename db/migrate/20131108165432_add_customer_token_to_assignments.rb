class AddCustomerTokenToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :customer_token, :string
  end
end
