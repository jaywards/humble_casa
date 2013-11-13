class RemoveStripeCardTokeFromServices < ActiveRecord::Migration
 	remove_column :services, :stripe_card_token
end
