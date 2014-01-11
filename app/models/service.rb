class Service < ActiveRecord::Base
  attr_accessible :address1, :address2, :city, :email, :name, :phone, :state, :zip, :user_id, 
  :biz_description,	:service_zips_attributes, :assignments_attributes, :time_zone, :employments_attributes,
  :stripe_customer_token, :stripe_access_token, :stripe_refresh_token, :stripe_publishable_key, :stripe_user_id,
  :stripe_card_token, :card_type, :last_four, :license, :insurance_company, :insurance_id, :experience, 
  :verify_details, :verified, :area_service, :category_ids

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :user_id, presence: true
  validates :categories, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX}
  validates :name, presence: true, length: {maximum: 150}
  validates :phone, presence: true, length: {maximum: 15}
  validates :address1, presence: true, length: {maximum: 150}
  validates :address2, length: {maximum: 150}
  validates :city, presence: true, length: {maximum: 150}
  validates :state, presence: true, length: {maximum: 2}
  validates :zip, presence: true, length: {maximum: 10}
  validates :biz_description, presence: true
  
  belongs_to :owner, class_name: "User"

  has_many :assignments, dependent: :destroy
  has_many :properties, through: :assignments
  accepts_nested_attributes_for :assignments

  has_many :employments, dependent: :destroy
  has_many :users, through: :employments
  accepts_nested_attributes_for :employments

  has_many :service_zips, dependent: :destroy
  accepts_nested_attributes_for :service_zips, reject_if: :all_blank, allow_destroy: :true

  has_many :service_requests

  has_and_belongs_to_many :categories

  has_one :location, dependent: :destroy

  has_reputation :ratings, source: :user, aggregated_by: :average

  def service_servicezips
    ServiceZip.where("service_id = ?", id)
  end

  def service_employees
    User.find(Employment.where("service_id = ?", id).map(&:user_id).uniq) 
  end

  def update_payment_info
    if valid?
      Stripe.api_key = ENV['STRIPE_API_KEY']
      customer = Stripe::Customer.create(description: name, card: stripe_card_token, plan: 'service_monthly')
      self.stripe_customer_token = customer.id
      save!
    end
    rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

  def create_monthly_charge_invoice(property)
    if valid?
      Stripe.api_key = ENV['STRIPE_API_KEY']
      item = Stripe::InvoiceItem::create(
        customer: self.stripe_customer_token,
        amount: 300,
        currency: "usd",
        description:  "Active customer (" + property.name + " / " +  
              property.user.full_name + ") charge for " + Date::MONTHNAMES[Date.today.month], 
        metadata: {
          'type' => 'monthly_fee', 
          'service_id' => self.id.to_s, 
          'property_id' => property.id.to_s, 
          'month' => Date.today.month.to_s,
          }
        )
    end
    rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while charging the service the monthly subscription fee: #{e.message}"
    errors.add :base, "There was a problem with creating the monthly fee for this customer. HumbleCasa will 
    resolve it and update you on the status."
    false
  end

  def service_employees
    User.find(Employment.where("service_id = ?", id).map(&:user_id).uniq) 
  end

  def address_for_location
    address1 + " " + address2 + ", " + city + ", " + state
  end

  def payment_ok
    !stripe_card_token.nil? && !stripe_card_token.empty?
  end

  def stripe_ok
    !stripe_access_token.nil? && !stripe_access_token.empty?
  end

  def check_status
    if (self.payment_ok && self.stripe_ok && self.verified) || self.area_service
      if service_active == false
        self.service_active = true
        save!
      end
    else
      if service_active == true
        self.service_active = false
        save!
      end
    end
  end

  def unfinalized
    self.assignments.find_all {|x| x.confirmed == false || x.cost == 0}
  end

  def uncompleted_count
    self.service_requests.find_all { |x| x.completed == false}.size
  end

  def unassigned
    self.service_requests.find_all {|x| x.assigned == false}
  end

  def unscheduled
    self.service_requests.find_all {|x| x.assigned == true && x.scheduled == false && x.completed == false}
  end

  def uncompleted
    self.service_requests.find_all {|x| x.completed == false && x.scheduled == true}
  end

  def new_employees
    self.employments.find_all {|x| x.approved == nil}
  end

  def new_assignments(user)
    self.assignments.find_all {|x| x.updated_at > user.last_login_at} 
  end

  def new_completed(user)
    self.service_requests.find_all {|x| x.completed == true && x.updated_at > user.last_login_at} 
  end

  def today_jobs
    self.service_requests.find_all {|x| x.completed == false && x.first_scheduled.day == Date.today.day && x.first_scheduled.month == Date.today.month && x.first_scheduled.year == Date.today.year}
  end

  def charged_srs
    self.service_requests.find_all {|x| x.charge_date != nil && x.charge_date > Date.today - 7.days }
  end

  def mail_notification
    NotificationMailer.delay.new_service(self) if Rails.env.production?
  end

end
