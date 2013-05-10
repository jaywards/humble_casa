class CreateAssociations < ActiveRecord::Migration
  def change
    create_table :associations do |t|
      t.string :category
      t.integer :property_id
      t.integer :service_id

      t.timestamps
    end

    add_index :associations, :property_id
    add_index :associations, :service_id
  end
end
