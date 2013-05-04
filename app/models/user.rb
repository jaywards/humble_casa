class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :last_name, :first_name, :primary_phone, :role
  acts_as_authentic
  has_many :properties, dependent: :destroy
  has_many :services, dependent: :destroy

  ROLES = %w[propertyowner serviceowner employee admin]

  def role_symbols
  	[role.to_sym]
  end

  def user_properties
  	Property.where("user_id = ?", id)
  end

  def user_services
    Service.where("user_id = ?", id)
  end


end
