class AddBusinessCodeToServices < ActiveRecord::Migration
  def change
    add_column :services, :business_code, :string
  end
end
