class AddVerifiedToServices < ActiveRecord::Migration
  def change
    add_column :services, :verified, :boolean, default: false
    add_column :services, :license, :string
    add_column :services, :insurance_company, :string
    add_column :services, :insurance_id, :string
    add_column :services, :experience, :integer
    add_column :services, :verify_details, :string
    remove_column :services, :business_code
    end
end
