class AddServicePhoto2ToServiceRequest < ActiveRecord::Migration
  def change
    add_column :service_requests, :service_photo_2, :string
    add_column :service_requests, :service_photo_3, :string
  end
end
