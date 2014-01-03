class AddAreaServiceToServices < ActiveRecord::Migration
  def change
    add_column :services, :area_service, :boolean
    add_column :services, :yelp, :string
    add_column :services, :image, :string
  end
end
