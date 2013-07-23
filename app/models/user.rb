class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :last_name, :first_name, :primary_phone, :role, :employer_id, 
    :employments_attributes, :work_assignments_attributes
  
  acts_as_authentic

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false}
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :last_name, presence: true, length: {maximum: 25}
  validates :first_name, presence: true, length: {maximum: 25}
  validates :primary_phone, presence: true
  validates :role, presence: true
  
  has_many :properties, dependent: :destroy
  
  has_one :business, class_name: "Service", dependent: :destroy
  
  has_many :employments, dependent: :destroy
  has_many :services, through: :employments
  accepts_nested_attributes_for :employments
  
  has_many :work_assignments, dependent: :destroy
  has_many :service_requests, through: :work_assignments
  accepts_nested_attributes_for :work_assignments



  ROLES = %w[propertyowner serviceowner employee admin]

  def role_symbols
  	[role.to_sym]
  end

  def user_properties
  	Property.where("user_id = ?", id)
  end

  def user_service
    Service.where("user_id = ?", id)
  end

  def to_label
    "#{last_name}, #{first_name}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
