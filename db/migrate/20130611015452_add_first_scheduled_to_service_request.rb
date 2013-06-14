class AddFirstScheduledToServiceRequest < ActiveRecord::Migration
  def change
    add_column :service_requests, :first_scheduled, :datetime
  end
end
