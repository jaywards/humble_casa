class AddColumnAllAssignedToServiceRequest < ActiveRecord::Migration
  def change
    add_column :service_requests, :all_assigned, :boolean
  end
end
