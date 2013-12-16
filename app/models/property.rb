class Property < ActiveRecord::Base
  attr_accessible :address1, :address2, :city, :instructions, :name, :phone, :state, :zip, :time_zone, 
  :assignments_attributes, :stripe_customer_token, :stripe_card_token, :card_type, :last_four;

  belongs_to :user
  
  has_many :assignments, dependent: :destroy
  has_many :services, through: :assignments
  accepts_nested_attributes_for :assignments

  has_many :service_requests

  has_one :location, dependent: :destroy

  validates :user_id, presence: true
  validates :name, presence: true, length: {maximum: 150}
  validates :phone, length: {maximum: 15}
  validates :address1, presence: true, length: {maximum: 150}
  validates :address2, length: {maximum: 150}
  validates :city, presence: true, length: {maximum: 150}
  validates :state, presence: true, length: {maximum: 2}
  validates :zip, presence: true, length: {maximum: 10}

  default_scope order: 'properties.created_at DESC'

  
  def full_address
    if address2.nil?
      return (address1 + ", " + city + ", " + state + " " + zip)
    else
      return (address1 + ", " + address2 + ", " + city + ", " + state + " " + zip)
    end
  end

  def name_with_owner
    return name + " / " + self.user.full_name
  end

  def any_services
    if ServiceZip.where("zip = ?", zip).size > 0
      return true
    else
      return false
    end
  end

  def update_payment_info
   if valid?  
      Stripe.api_key = ENV['STRIPE_API_KEY']
      customer = Stripe::Customer.create(description: name, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!  
    end
    rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

  def update_assignments_customers
    self.assignments.each do |a|
      if !a.service_id.nil? && (!a.stripe_customer_token.nil? || !a.stripe_customer_token.empty?)
        @card_token = Stripe::Token.create(
          {customer: stripe_customer_token},
          a.service.stripe_access_token
          )
        a.update_customer(@card_token.id)
      end
    end
  end

  def create_assignments_customers
    self.assignments.each do |a|
      if !a.service_id.nil? && (a.stripe_customer_token.nil? || a.stripe_customer_token.empty?)
        @card_token = Stripe::Token.create(
          {customer: stripe_customer_token},
          a.service.stripe_access_token
          )
        a.create_customer(@card_token.id)
      end
    end
  end

  def area_category_services(category)
    Service.includes(:service_zips).where(:category => category, :service_active => true, "service_zips.zip" => self.zip)
  end

  def area_services
    Service.find(ServiceZip.where(:zip => zip).map(&:service_id).uniq)
  end


  def check_availability(category)
    all_services = self.area_services
    all_services.each do |s|
      if s.category == category
        return true
      end
    end
    return false
  end

  def payment_ok
    !stripe_card_token.nil? && !stripe_card_token.empty?
  end

  def check_status
    if self.payment_ok
      if active == false
        self.active = true
        save!
      end
    else
      if active == true
        self.active = false
        save!
      end
    end
  end

  def remove_invalid_srs
    self.assignments.each do |a|
      @invalid_srs = self.service_requests.find_all {|x| x.completed == false && x.service_id != a.service_id}
      @invalid_srs.each do |sr|
        sr.destroy
      end
    end   
  end

  def completed_requests(service)
    @completed_requests = self.service_requests.find_all {|x| x.service_id == service.id && x.completed == true}
    if !@completed_requests.nil?
      @completed_requests.sort_by {|a| a.completed_date }
    end
    return @completed_requests
  end

  def new_completed(service, user)
    @new_completed = self.service_requests.find_all {|x| x.service_id == service.id && x.completed == true && x.updated_at > user.last_login_at}
    if !@new_requests.nil? 
      @new_requests.sort_by {|a| a.completed_date }
    end
    return @new_completed
  end

  def open_requests(service)
    @open_requests = self.service_requests.find_all {|x| x.service_id == service.id && x.completed == false}
    if !@open_requests.nil?
      @open_requests.sort_by {|a| a.first_scheduled }
    end
    return @open_requests
  end

  def has_serviced(service)
    return self.service_requests.find_all {|x| x.service_id == service.id}.size > 0
  end

  def add_categories
    if (@diff = Service::CATEGORIES.count - self.assignments.count) > 0
      @diff.times do 
        self.assignments.build
        save!
      end
    end
  end

  def label_categories
    Service::CATEGORIES.each do |category|
      if self.assignments.find_by_category(category).nil?
        @assignment = self.assignments.where("category IS NULL").limit(1)
        puts @assignment.first.id
        @assignment.first.category = category
        @assignment.first.save
        #@assignment.update_attribute(:category, category)
      end
    end
  end
end
