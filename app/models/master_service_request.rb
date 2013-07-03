class MasterServiceRequest < ActiveRecord::Base
  attr_accessible :first_scheduled, :frequency, :instructions, :onetime, :property_id, :request_id, :service_end_date, 
  				:service_id, :service_month_day, :service_start_date, :service_week_day, :all_assigned, :service_request_attributes,  
          :work_assignments_attributes

  belongs_to :property
  belongs_to :service

  has_many :service_requests, dependent: :destroy
  has_many :work_assignments
  has_many :users, through: :work_assignments
  accepts_nested_attributes_for :work_assignments

    def service_request_id
  		@request_id = "00R" + id.to_s + "S" + service_id.to_s + "P" + property_id.to_s
	end

end
