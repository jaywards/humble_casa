class MoreChangesToStripeFieldsForServices < ActiveRecord::Migration
  def change
    remove_column :services, :stripe_recipient_token
    add_column :services, :stripe_publishable_key, :string
    add_column :services, :stripe_user_id, :string
    add_column :services, :stripe_refresh_token, :string
  end
end
