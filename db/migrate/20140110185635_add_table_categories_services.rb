class AddTableCategoriesServices < ActiveRecord::Migration
 
def change
       create_table :categories_services, :id => false do |t|
      t.references :category, :service
    end

    add_index :categories_services, [:category_id, :service_id]
  end
end
