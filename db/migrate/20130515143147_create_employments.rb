class CreateEmployments < ActiveRecord::Migration
  def change
    create_table :employments do |t|
      t.integer :service_id
      t.integer :user_id

      t.timestamps
    end
  end
end
