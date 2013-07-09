class MasterServiceRequest < ActiveRecord::Base
  attr_accessible :first_scheduled, :frequency, :instructions, :onetime, :property_id, :request_id, :service_end_date, 
  				:service_id, :service_month_day, :service_start_date, :service_week_day, :all_assigned, :terms_agreement,
          :service_request_attributes, :work_assignments_attributes

  belongs_to :property
  belongs_to :service

  validates_inclusion_of :onetime, in: [true, false]
  validates :property_id, :service_id, :first_scheduled, presence: true
  
  #One-time fields
  validates :service_end_date, :service_start_date, presence: true
  #Repeating fields
  validates :service_month_day, :service_week_day, :frequency, presence: true




  has_many :service_requests, dependent: :destroy
  has_one :work_assignment
  accepts_nested_attributes_for :work_assignment
  has_one :user, through: :work_assignment
  
    def service_request_id
  		@request_id = "00R" + id.to_s + "S" + service_id.to_s + "P" + property_id.to_s
	end

end
