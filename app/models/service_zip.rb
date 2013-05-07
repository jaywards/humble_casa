class ServiceZip < ActiveRecord::Base
  attr_accessible :service_id, :zip
  belongs_to :service
end
