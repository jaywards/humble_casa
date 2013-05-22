class AddMailerFlagsToServiceRequest < ActiveRecord::Migration
  def change
  	add_column :service_requests, :mailed_created, :boolean, :default => false
  	add_column :service_requests, :mailed_assigned, :boolean, :default => false
  	add_column :service_requests, :mailed_completed, :boolean, :default => false

  end
end
