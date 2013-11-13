class ChangeStripeFieldsInProperties < ActiveRecord::Migration
 def change
    remove_column :properties, :stripe_customer_token
    add_column :properties, :stripe_card_token, :string
 end
end
