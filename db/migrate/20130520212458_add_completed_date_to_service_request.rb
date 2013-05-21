class AddCompletedDateToServiceRequest < ActiveRecord::Migration
  def change
    add_column :service_requests, :completed_date, :datetime
  end
end
