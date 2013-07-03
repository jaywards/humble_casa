class CreateMasterServiceRequests < ActiveRecord::Migration
  def change
    create_table :master_service_requests do |t|
      t.integer :property_id
      t.integer :service_id
      t.datetime :service_start_date
      t.datetime :service_end_date
      t.text :instructions
      t.string :request_id
      t.boolean :onetime
      t.string :frequency
      t.string :service_week_day
      t.integer :service_month_day
      t.datetime :first_scheduled

      t.timestamps
    end
  end
end
