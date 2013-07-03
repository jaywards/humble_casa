module ServiceRequestsHelper

	def open_requests(service, property)
		@open_requests = ServiceRequest.where(service_id: service.id, property_id: property.id, completed: false)
		if !@open_requests.empty?
			@open_requests.sort_by {|a| a.created_at }
		end
	end

	def completed_requests(service, property)
		@completed_requests = ServiceRequest.where(service_id: service.id, property_id: property.id, completed: true)
		if !@completed_requests.empty?
			@completed_requests.sort_by {|a| a.completed_date }
		end
	end

	def assigned_employee(service_request)
		User.find_by_id(WorkAssignment.where(service_request_id: service_request.id).first.user_id) 
	end

end
