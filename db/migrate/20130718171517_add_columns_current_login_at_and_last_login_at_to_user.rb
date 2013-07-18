class AddColumnsCurrentLoginAtAndLastLoginAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_login_in, :datetime
    add_column :users, :last_login_at, :datetime
  end
end
