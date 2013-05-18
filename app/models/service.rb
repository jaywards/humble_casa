class Service < ActiveRecord::Base
  attr_accessible :address1, :address2, :category, :city, :email, :name, :phone, :state, :zip, 
  	:service_zips_attributes, :assignments_attributes, :employments_attributes
  belongs_to :user

  has_many :assignments
  has_many :properties, through: :assignments
  accepts_nested_attributes_for :assignments

  has_many :employments
  has_many :users, through: :employments
  accepts_nested_attributes_for :employments

  has_many :service_zips, dependent: :destroy
  accepts_nested_attributes_for :service_zips, reject_if: :all_blank, allow_destroy: :true

  has_many :service_requests


  CATEGORIES = %w[landscaping pool/spa_cleaning housecleaning snow_removal handyman/general_maintenance]



  def service_servicezips
    ServiceZip.where("service_id = ?", id)
  end

  def service_employees
    User.find(Employment.where("service_id = ?", id).map(&:user_id).uniq) 
  end

end
