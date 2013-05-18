class CreateServiceRequests < ActiveRecord::Migration
  def change
    create_table :service_requests do |t|
      t.boolean :assigned, :default => false
      t.boolean :completed, :default => false
      t.integer :property_id
      t.integer :service_id
      t.datetime :service_start_date
      t.datetime :service_end_date
      t.text :instructions

      t.timestamps
    end
  end
end
