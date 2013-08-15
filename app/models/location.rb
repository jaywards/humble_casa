class Location < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  belongs_to :property
  belongs_to :service_request
  belongs_to :service

end