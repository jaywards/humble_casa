class AddNewAccountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :new_account, :boolean, default: true
  end
end
