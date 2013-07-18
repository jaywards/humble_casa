class AddServicePhoto1ToServiceRequest < ActiveRecord::Migration
  def change
    add_column :service_requests, :service_photo_1, :string
  end
end
