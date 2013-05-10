class Service < ActiveRecord::Base
  attr_accessible :address1, :address2, :category, :city, :email, :name, :phone, :state, :zip, 
  	:service_zips_attributes, :assignments_attributes
  belongs_to :user

  has_many :assignments
  has_many :properties, through: :assignments
  accepts_nested_attributes_for :assignments

  has_many :service_zips, dependent: :destroy
  accepts_nested_attributes_for :service_zips, reject_if: :all_blank, allow_destroy: :true


  CATEGORIES = %w[landscaping pool/spa_cleaning housecleaning snow_removal handyman/general_maintenance]

end
