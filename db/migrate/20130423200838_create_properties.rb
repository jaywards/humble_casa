class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :instructions
      t.integer :user_id

      t.timestamps
    end
    add_index :properties, :user_id
  end
end
