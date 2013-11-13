class AddStripeToServices < ActiveRecord::Migration
  def change
    add_column :services, :stripe_customer_token, :string
    add_column :services, :accept_cc, :boolean, default: false
  end
end
