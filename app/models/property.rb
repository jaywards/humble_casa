class Property < ActiveRecord::Base
  attr_accessible :address1, :address2, :city, :instructions, :name, :phone, :state, :zip
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true, length: {maximum: 150}
  validates :phone, presence: true, length: {maximum: 15}
  validates :address1, presence: true, length: {maximum: 150}
  validates :address2, length: {maximum: 150}
  validates :city, presence: true, length: {maximum: 150}
  validates :state, presence: true, length: {maximum: 2}
  validates :zip, presence: true, length: {maximum: 10}

  default_scope order: 'properties.created_at DESC'

end