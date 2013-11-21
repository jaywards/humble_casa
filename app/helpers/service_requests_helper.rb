module ServiceRequestsHelper

	def assigned_employee(service_request)
		User.find_by_id(WorkAssignment.where(service_request_id: service_request.id).first.user_id) 
	end


end
