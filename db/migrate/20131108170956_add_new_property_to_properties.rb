class AddNewPropertyToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :new_property, :boolean, default: true
  end
end
