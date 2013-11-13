class Service < ActiveRecord::Base
  attr_accessible :address1, :address2, :category, :city, :email, :name, :phone, :state, :zip, :user_id, 
  :biz_description,	:service_zips_attributes, :assignments_attributes, :time_zone, :employments_attributes,
  :stripe_customer_token, :stripe_access_token, :stripe_refresh_token, :stripe_publishable_key, :stripe_user_id,
  :stripe_card_token, :card_type, :last_four

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :user_id, presence: true
  validates :category, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX}
  validates :name, presence: true, length: {maximum: 150}
  validates :phone, presence: true, length: {maximum: 15}
  validates :address1, presence: true, length: {maximum: 150}
  validates :address2, length: {maximum: 150}
  validates :city, presence: true, length: {maximum: 150}
  validates :state, presence: true, length: {maximum: 2}
  validates :zip, presence: true, length: {maximum: 10}

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

  has_one :location, dependent: :destroy

  has_reputation :ratings, source: :user, aggregated_by: :average


  CATEGORIES = %w[landscaping pool/spa_cleaning housecleaning snow_removal handyman/general_maintenance]
    #also need to update Services form if changing categories
  
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
    if self.payment_ok && self.stripe_ok
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

end
