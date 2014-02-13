class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :last_name, :first_name, :primary_phone, :role, 
  :employer_id, :notify, :employment_attributes, :work_assignments_attributes
  
  acts_as_authentic

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX}, 
              uniqueness: { case_sensitive: false}, if: :password_changed?
  validates :password, presence: true, length: { minimum: 6 }, if: :password_changed?
  validates :password_confirmation, presence: true, if: :password_changed?
  validates :last_name, presence: true, length: {maximum: 25}
  validates :first_name, presence: true, length: {maximum: 25}
  validates :primary_phone, presence: true
  validates :role, presence: true
  
  has_many :properties, dependent: :destroy
  
  has_one :business, class_name: "Service", foreign_key: "owner_id", dependent: :destroy
  
  has_one :employment, dependent: :destroy
  has_one :employer, class_name: "Service", through: :employment, source: :service
  
  accepts_nested_attributes_for :employment
  
  has_many :work_assignments, dependent: :destroy
  has_many :service_requests, through: :work_assignments
  accepts_nested_attributes_for :work_assignments

  ROLES = %w[propertyowner serviceowner employee admin]

  def role_symbols
  	[role.to_sym]
  end

  def to_label
    "#{last_name}, #{first_name}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def last_firstInitial
    "#{last_name}, #{first_name[0]}"
  end

  def mail_notification
    NotificationMailer.delay.welcome(self) if Rails.env.production?
    NotificationMailer.delay.new_user(self) if Rails.env.production?
  end

  def mail_new_employee
    reset_perishable_token!
    NotificationMailer.delay.new_employee(self)
  end

  def mail_password_reset
    reset_perishable_token!
    NotificationMailer.delay.password_reset(self)
  end

  def us_states
    [
      ['AK', 'AK'],
      ['AL', 'AL'],
      ['AR', 'AR'],
      ['AZ', 'AZ'],
      ['CA', 'CA'],
      ['CO', 'CO'],
      ['CT', 'CT'],
      ['DC', 'DC'],
      ['DE', 'DE'],
      ['FL', 'FL'],
      ['GA', 'GA'],
      ['HI', 'HI'],
      ['IA', 'IA'],
      ['ID', 'ID'],
      ['IL', 'IL'],
      ['IN', 'IN'],
      ['KS', 'KS'],
      ['KY', 'KY'],
      ['LA', 'LA'],
      ['MA', 'MA'],
      ['MD', 'MD'],
      ['ME', 'ME'],
      ['MI', 'MI'],
      ['MN', 'MN'],
      ['MO', 'MO'],
      ['MS', 'MS'],
      ['MT', 'MT'],
      ['NC', 'NC'],
      ['ND', 'ND'],
      ['NE', 'NE'],
      ['NH', 'NH'],
      ['NJ', 'NJ'],
      ['NM', 'NM'],
      ['NV', 'NV'],
      ['NY', 'NY'],
      ['OH', 'OH'],
      ['OK', 'OK'],
      ['OR', 'OR'],
      ['PA', 'PA'],
      ['RI', 'RI'],
      ['SC', 'SC'],
      ['SD', 'SD'],
      ['TN', 'TN'],
      ['TX', 'TX'],
      ['UT', 'UT'],
      ['VA', 'VA'],
      ['VT', 'VT'],
      ['WA', 'WA'],
      ['WI', 'WI'],
      ['WV', 'WV'],
      ['WY', 'WY']
    ]
  end
end
