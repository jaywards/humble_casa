class AddColumnPropertyIdToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :property_id, :integer
    add_column :locations, :service_request_id, :integer
  end
end
