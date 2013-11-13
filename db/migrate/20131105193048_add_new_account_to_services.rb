class AddNewAccountToServices < ActiveRecord::Migration
  def change
    add_column :services, :new_account, :boolean, default: true
  end
end
