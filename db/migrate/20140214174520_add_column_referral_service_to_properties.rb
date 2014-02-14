class AddColumnReferralServiceToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :referral_service, :integer
  end
end
