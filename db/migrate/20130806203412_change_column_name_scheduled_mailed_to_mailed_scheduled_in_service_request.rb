class ChangeColumnNameScheduledMailedToMailedScheduledInServiceRequest < ActiveRecord::Migration
  	def change
		add_column :service_requests, :mailed_scheduled, :boolean, default: false
		remove_column :service_requests, :scheduled_mailed
	end
end
