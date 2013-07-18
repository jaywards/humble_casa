class Employment < ActiveRecord::Base
  attr_accessible :service_id, :user_id, :approved

  belongs_to :user
  belongs_to :service 
  

end
