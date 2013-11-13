class AddStripeCardTokenToServices < ActiveRecord::Migration
  def change
    add_column :services, :stripe_card_token, :string
  end
end
