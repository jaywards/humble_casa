class AddStripeCardTokenToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :stripe_card_token, :string
  end
end
