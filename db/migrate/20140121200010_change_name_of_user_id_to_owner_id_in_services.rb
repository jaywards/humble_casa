class ChangeNameOfUserIdToOwnerIdInServices < ActiveRecord::Migration
  def change
  	rename_column :services, :user_id, :owner_id
  end
end
