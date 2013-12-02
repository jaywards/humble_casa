class StripesController < ApplicationController
	force_ssl

	def stripe_signup
		@user = current_user
		@service = @user.business
	    if params[:state] == "1234"
	      code = params[:code]
	      customer = ActiveSupport::JSON.decode(`curl -X POST https://connect.stripe.com/oauth/token -d client_secret=#{ENV['STRIPE_API_KEY']} -d code=#{code} -d grant_type=authorization_code`)
	      @service.update_attributes(
	        :stripe_access_token => customer['access_token'], 
	        :stripe_refresh_token => customer['refresh_token'],
	        :stripe_publishable_key => customer['stripe_publishable_key'],
	        :stripe_user_id => customer['stripe_user_id'])
	      @user.update_attribute(:new_account, false)
	    end
	end

	def edit_stripe
		@user = current_user
		@service = @user.business
	    if params[:state] == "1234"
	      code = params[:code]
	      customer = ActiveSupport::JSON.decode(`curl -X POST https://connect.stripe.com/oauth/token -d client_secret=#{ENV['STRIPE_API_KEY']} -d code=#{code} -d grant_type=authorization_code`)
	      @service.update_attributes(
	        :stripe_access_token => customer['access_token'], 
	        :stripe_refresh_token => customer['refresh_token'],
	        :stripe_publishable_key => customer['stripe_publishable_key'],
	        :stripe_user_id => customer['stripe_user_id'])
	      @user.update_attribute(:new_account, false)
	    end
	end

end
