class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :last_name, :first_name, :primary_phone
  acts_as_authentic
  has_many :properties, dependent: :destroy

  def user_properties
  	Property.where("user_id = ?", id)
  end

end
