class MasterServiceRequest < ActiveRecord::Base
  attr_accessible :first_scheduled, :frequency, :instructions, :onetime, :property_id, :request_id, :service_end_date, 
  				:service_id, :service_month_day, :service_start_date, :service_week_day, :all_assigned, :terms_agreement,
          :paused, :time_zone, :duration, :all_scheduled, :service_request_attributes, :work_assignments_attributes, 
          :charge, :assignment_id

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

  def spawnServiceRequest(assignee)
    
    @service_request = ServiceRequest.new
    @service_request.updateServiceRequest(self)
    
    if assignee.nil?
      @service_request.build_work_assignment
      @service_request.assigned = false
    else
      @service_request.build_work_assignment(user_id: assignee.id)
      @service_request.assigned = true
    end
    @service_request.completed = false
    @service_request.location_verified = false
    @service_request.timestamp_verified = false
    @service_request.build_location

    if self.all_scheduled
      @service_request.scheduled = true
    end

    return @service_request
  end


  def update_first_scheduled
    case frequency
      when "weekly"
        @next_scheduled = first_scheduled + 1.week
      when "every_other_week"
        @next_scheduled = first_scheduled + 2.weeks
      when "monthly"
        @next_scheduled = first_scheduled + 1.month
      when "every_other_month"
        @next_scheduled = first_scheduled + 2.months
    end
    self.first_scheduled = @next_scheduled
    save!
  end

  def schedule_change_requiring_email(sr)
    if sr.mailed_scheduled && sr.mailed_assigned
      if self.onetime != sr.onetime || self.frequency != sr.frequency || self.service_end_date != sr.service_end_date || 
        self.service_start_date != sr.service_start_date || self.service_month_day != sr.service_month_day || 
        self.service_week_day != sr.service_week_day
        return true
      end
    end
    return false
  end

end
