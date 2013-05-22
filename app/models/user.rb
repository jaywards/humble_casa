class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :last_name, :first_name, :primary_phone, :role, :employer_id, 
    :employments_attributes, :work_assignments_attributes
  
  acts_as_authentic

  has_many :properties, dependent: :destroy
  has_many :services, dependent: :destroy

  has_many :employments
  has_many :services, through: :employments
  accepts_nested_attributes_for :employments

  has_many :work_assignments
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
    "#{first_name}, #{last_name}"
  end
end
