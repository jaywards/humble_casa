class UpdateStripeFieldsInAssignments < ActiveRecord::Migration
  def change
    remove_column :assignments, :customer_token
  end
end
