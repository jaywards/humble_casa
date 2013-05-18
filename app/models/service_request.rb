class ServiceRequest < ActiveRecord::Base
  attr_accessible :assigned, :completed, :instructions, :property_id, :service_end_date, :service_id, :service_start_date, 
  	:work_assignments_attributes

  belongs_to :property
  belongs_to :service

  has_many :work_assignments
  has_many :users, through: :work_assignments
  accepts_nested_attributes_for :work_assignments

end
