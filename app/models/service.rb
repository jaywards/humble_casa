class Service < ActiveRecord::Base
  attr_accessible :address1, :address2, :category, :city, :email, :name, :phone, :state, :zip, :user_id, 
  :biz_description,	:service_zips_attributes, :assignments_attributes, :time_zone, :employments_attributes

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


  CATEGORIES = %w[landscaping pool/spa_cleaning housecleaning snow_removal handyman/general_maintenance]
    #also need to update Services form if changing categories


  def service_servicezips
    ServiceZip.where("service_id = ?", id)
  end

  def service_employees
    User.find(Employment.where("service_id = ?", id).map(&:user_id).uniq) 
  end

end
