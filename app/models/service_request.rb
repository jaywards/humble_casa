class ServiceRequest < ActiveRecord::Base
  attr_accessible :assigned, :completed, :instructions, :property_id, :service_end_date, :service_id, :service_start_date, 
  :request_id, :completed_date, :onetime, :frequency, :service_week_day, :service_month_day, :asap, :first_scheduled, 
  :all_assigned, :master_service_request_id, :work_assignment_attributes, :completion_note, :service_photo_1, 
  :service_photo_2, :service_photo_3, :scheduled, :time_zone, :duration, :all_scheduled, :charge, :charge_notes

  mount_uploader :service_photo_1, ServicePicsUploader  
  mount_uploader :service_photo_2, ServicePicsUploader  
  mount_uploader :service_photo_3, ServicePicsUploader  

  has_one :work_assignment, dependent: :destroy
  accepts_nested_attributes_for :work_assignment
  has_one :user, through: :work_assignment
  
  belongs_to :property
  belongs_to :service
  belongs_to :master_service_request
  has_one :location, dependent: :destroy
  
  def service_request_id
  		@request_id = "00R" + id.to_s + "S" + service_id.to_s + "P" + property_id.to_s
	end
 
 WEEKDAYS = %w[Monday Tuesday Wednesday Thursday Friday]

end
