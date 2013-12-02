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

  def create_charge
    if valid?
      Stripe.api_key = self.service.stripe_access_token
      charge = Stripe::Charge::create(
        amount: (self.charge * 100).round,
        currency: "usd",
        customer: Assignment.find_by_service_id_and_property_id(self.service.id, self.property.id).stripe_customer_token,
        description:  "Service on " + 
          DateTime.parse(self.completed_date.to_s).in_time_zone(self.property.time_zone).strftime("%m/%d/%Y") +
          " by " + self.service.name, 
        metadata: {'type' => 'to_property', 'service_id' => self.service.id.to_s, 
          'property_id' => self.property.id.to_s, 'service_request_id' => self.id}
      )
      self.charge_id = charge.id
      self.charge_date = Date.today
      save!
    end
    rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while charging for this service request: #{e.message}"
    errors.add :base, "There was a problem with the creating the charge for this service request. HumbleCasa will 
    resolve it and update you on the status."
    false
  end
  
  def add_charge_to_service_invoice
    if valid?
      Stripe.api_key = ENV['STRIPE_API_KEY']
      item = Stripe::InvoiceItem::create(
        customer: self.service.stripe_customer_token,
        amount: 150,
        currency: "usd",
        description:  "Service on " + 
          DateTime.parse(self.completed_date.to_s).in_time_zone(self.property.time_zone).strftime("%m/%d/%Y") +
          " by " + self.service.name, 
        metadata: {'type' => 'service_request', 'service_id' => self.service.id.to_s, 
          'property_id' => self.property.id.to_s, 'service_request_id' => self.id}
      )
      self.invoice_id = item.id
      self.invoice_date = Date.today
      save!
    end
    rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while charging the service for this service request: #{e.message}"
    errors.add :base, "There was a problem with creating the invoice for this service request. HumbleCasa will 
    resolve it and update you on the status."
    false
  end        

  def process_photos  
    if EXIFR::JPEG.new(self.service_photo_1.current_path).exif?
      @a = EXIFR::JPEG.new(self.service_photo_1.current_path)

      @lat = @a.exif[0].gps_latitude[0].to_f + 
          (@a.exif[0].gps_latitude[1].to_f / 60) + 
            (@a.exif[0].gps_latitude[2].to_f / 3600)

      @long = @a.exif[0].gps_longitude[0].to_f + 
          (@a.exif[0].gps_longitude[1].to_f / 60) + 
          (@a.exif[0].gps_longitude[2].to_f / 3600)

      @long = @long * -1 if @a.exif[0].gps_longitude_ref == "W"
      @lat = @lat * -1 if @a.exif[0].gps_latitude_ref == "S"

      self.location.update_attribute(:latitude, @lat)
      self.location.update_attribute(:longitude, @long)

      if @long >= (self.property.location.longitude - 1) &&
          @long <= (self.property.location.longitude + 1) &&
          @lat >= (self.property.location.latitude - 1) &&
          @lat <= (self.property.location.latitude + 1) &&
        self.update_attribute(:location_verified, true)
      end

      @ts = EXIFR::JPEG.new(self.service_photo_1.current_path).date_time
      @completed_date = self.completed_date
      if @ts >= (@completed_date - 24.hours) && @ts <= (@completed_date + 24.hours)
        self.update_attribute(:timestamp_verified, true)
      end
    end
  end
 
  def create_next
    @master_request = MasterServiceRequest.find_by_id(self.master_service_request_id)

    ## If all_assigned copy the assignment to new request. Both cases will handle all_assigned within the spawn helper
    if @master_request.all_assigned
      @new_service_request = @master_request.spawnServiceRequest(self.user)
    else
      @new_service_request = @master_request.spawnServiceRequest(nil)
    end 
      @new_service_request.link_to_master(@master_request)
      
    ## Update next scheduled (will handle all_assigned - time of service carries over)
    @master_request.update_first_scheduled
    @new_service_request.first_scheduled = @new_service_request.completed_date = @master_request.first_scheduled

    ## Handle if paused
    if @master_request.paused?
      @master_request.update_attribute(:paused, false)
      @new_service_request.paused = false
    end

    @new_service_request.save
  
  end


  def updateServiceRequest(master_request)
    self.instructions = master_request.instructions
    self.property_id = master_request.property_id
    self.service_id = master_request.service_id
    self.service_start_date = master_request.service_start_date
    self.service_end_date = master_request.service_end_date
    self.onetime = master_request.onetime
    self.first_scheduled = master_request.first_scheduled
    self.frequency = master_request.frequency
    self.service_week_day = master_request.service_week_day
    self.service_month_day = master_request.service_month_day
    self.first_scheduled = master_request.first_scheduled
    self.completed_date = master_request.first_scheduled
    self.paused = master_request.paused
    self.all_assigned = master_request.all_assigned
    self.time_zone = master_request.time_zone
    self.duration = master_request.duration
    self.all_scheduled = master_request.all_scheduled
    self.charge = master_request.charge  
  end

  def link_to_master(master_request)
    self.update_attribute(:master_service_request_id, master_request.id)
    master_request.update_attribute(:active_request_id, id)
  end

  def mail_completed(charge_success)
    if charge_success
      ServiceMailer.service_completed(self).deliver
    else
      ServiceMailer.service_completed_charge_issue(self).deliver
    end  
    self.update_attribute(:mailed_completed, true)
    
    if self.all_assigned || self.all_scheduled
      @newSR_id = MasterServiceRequest.find_by_id(self.master_service_request_id).active_request_id
      @newSR = ServiceRequest.find_by_id(@newSR_id)
      if self.all_assigned
        ServiceMailer.service_assigned(@newSR).deliver
        @newSR.update_attribute(:mailed_assigned, true)
      end
      if self.all_scheduled
        ServiceMailer.service_scheduled(@newSR).deliver
        @newSR.update_attribute(:mailed_scheduled, true)
      end
    end
  end

  def mail_assigned
    ServiceMailer.service_assigned(self).deliver
    self.mailed_assigned = true
    save!
  end

  def mail_scheduled
    ServiceMailer.service_scheduled(self).deliver
    self.mailed_scheduled = true
    save! 
  end

  def mail_created
    ServiceMailer.service_created(self).deliver
    self.mailed_created = true
    save!
  end 

  def assignment
    Assignment.find_by_service_id_and_property_id(self.service, self.property)
  end

  def reschedule(mr)
    self.mailed_scheduled = false
    self.scheduled = false

    ServiceMailer.service_rescheduled(self, mr).deliver
    
  end

 WEEKDAYS = %w[Monday Tuesday Wednesday Thursday Friday]

end
