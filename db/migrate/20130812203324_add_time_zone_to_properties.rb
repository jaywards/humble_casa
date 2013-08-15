class AddTimeZoneToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :time_zone, :string
  end
end
