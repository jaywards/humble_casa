class AddRepeatingDetailsToServiceRequests < ActiveRecord::Migration
  def change
  	add_column :service_requests, :onetime, :boolean
  	add_column :service_requests, :frequency, :string
  	add_column :service_requests, :service_week_day, :string
  	add_column :service_requests, :service_month_day, :string
  	add_column :service_requests, :asap, :boolean
  end
end
