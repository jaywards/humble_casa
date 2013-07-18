class RemoveColumnCurrentLoginInInUser < ActiveRecord::Migration
  def change
    add_column :users, :current_login_at, :datetime
    remove_column :users, :current_login_in, :datetime
  end
end
