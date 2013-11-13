class UpdateStripeFieldsInProperties < ActiveRecord::Migration
	def change
	    add_column :properties, :stripe_customer_token, :string
	    remove_column :properties, :card_token, :string
  	end
end
