class Assignment < ActiveRecord::Base
  attr_accessible :category, :property_id, :service_id, :interested, :confirmed, :cost, :note

  belongs_to :service
  belongs_to :property

end
