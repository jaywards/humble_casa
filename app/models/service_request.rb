class ServiceRequest < ActiveRecord::Base
  attr_accessible :assigned, :completed, :instructions, :property_id, :service_end_date, :service_id, :service_start_date, 
  :request_id, :completed_date, :onetime, :frequency, :service_week_day, :service_month_day, :asap, :first_scheduled, 
  :all_assigned, :master_service_request_id, :work_assignments_attributes, :completion_note

  belongs_to :property
  belongs_to :service
  belongs_to :master_service_request

  has_many :work_assignments
  has_many :users, through: :work_assignments
  accepts_nested_attributes_for :work_assignments

  def service_request_id
  		@request_id = "00R" + id.to_s + "S" + service_id.to_s + "P" + property_id.to_s
	end
 
 WEEKDAYS = %w[Monday Tuesday Wednesday Thursday Friday]

end
