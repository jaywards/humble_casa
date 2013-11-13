class AddCardTokenToProperties < ActiveRecord::Migration
  def change
    remove_column :properties, :stripe_customer_token, :string
    add_column :properties, :card_token, :string
  end
end
