module ServiceRequestsHelper

	def open_requests(service, property)
		@open_requests = ServiceRequest.where(service_id: service.id, property_id: property.id)
		if !@open_requests.empty?
			@open_requests.sort_by {|a| a.created_at }
		end
	end

end
