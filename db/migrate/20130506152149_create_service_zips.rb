class CreateServiceZips < ActiveRecord::Migration
  def change
    create_table :service_zips do |t|
      t.string :zip
      t.integer :service_id

      t.timestamps
    end

    add_index :service_zips, :service_id
  end
end
