class AddBillingFrequencyToServices < ActiveRecord::Migration
  def change
    add_column :services, :billing_frequency, :string
    add_column :services, :service_active, :boolean, default: false
  end
end
