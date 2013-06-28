class Assignment < ActiveRecord::Base
  attr_accessible :category, :property_id, :service_id, :interested

  belongs_to :property
  belongs_to :service

end
