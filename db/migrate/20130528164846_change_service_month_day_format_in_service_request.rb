class ChangeServiceMonthDayFormatInServiceRequest < ActiveRecord::Migration
  def change
    change_column :service_requests, :service_month_day, :integer
  end
end
