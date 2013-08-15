class AddColumnServiceIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :service_id, :integer
  end
end
