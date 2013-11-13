class AddStripeColumnToAssignments < ActiveRecord::Migration
 def change
    add_column :assignments, :stripe_customer_token, :string
  end
end
