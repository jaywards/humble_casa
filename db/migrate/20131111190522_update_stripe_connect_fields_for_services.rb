class UpdateStripeConnectFieldsForServices < ActiveRecord::Migration
  def change
    remove_column :services, :accept_cc
    remove_column :services, :account_name
    remove_column :services, :account_type
    remove_column :services, :account_nickname
    remove_column :services, :billing_frequency
    add_column :services, :stripe_access_token, :string
  end
end
