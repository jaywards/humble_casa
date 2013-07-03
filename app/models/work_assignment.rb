class WorkAssignment < ActiveRecord::Base
  attr_accessible :user_id, :service_request_id, :master_service_request_id

  belongs_to :service_request
  belongs_to :master_service_request
  belongs_to :user

end
