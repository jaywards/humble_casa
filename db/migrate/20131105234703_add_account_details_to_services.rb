class AddAccountDetailsToServices < ActiveRecord::Migration
  def change
    add_column :services, :account_name, :string
    add_column :services, :stripe_recipient_token, :string
    add_column :services, :account_type, :string
    add_column :services, :account_nickname, :string
  end
end
