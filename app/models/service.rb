class Service < ActiveRecord::Base
  attr_accessible :address1, :address2, :category, :city, :email, :name, :phone, :state, :zip, :service_zips_attributes
  belongs_to :user
  has_many :service_zips, dependent: :destroy
  accepts_nested_attributes_for :service_zips

  CATEGORIES = %w[landscaping pool/spa_cleaning housecleaning snow_removal handyman/general_maintenance]

end
