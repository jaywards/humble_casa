class AddStripeToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :stripe_customer_token, :string
  end
end
