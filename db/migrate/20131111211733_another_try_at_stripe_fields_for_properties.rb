class AnotherTryAtStripeFieldsForProperties < ActiveRecord::Migration
    def change
    	add_column :properties, :stripe_customer_token, :string
    	remove_column :properties, :stripe_card_token
	end
end
