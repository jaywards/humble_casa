module ApplicationHelper

	def full_title(page_title)
		base_title = "HumbleCasa"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def signed_in?
		!current_user.nil?
	end 

	
	def spawnServiceRequest(master_request)
		
		@service_request = ServiceRequest.new(params[:service_request])
		@service_request = updateServiceRequest(@service_request, master_request)
		@service_request.assigned = false
		@service_request.completed = false
		@service_request.work_assignments.build

		return @service_request

	end

	def updateServiceRequest(service_request, master_request)
		service_request.instructions = master_request.instructions
		service_request.property_id = master_request.property_id
		service_request.service_id = master_request.service_id
		service_request.service_start_date = master_request.service_start_date
		service_request.service_end_date = master_request.service_end_date
		service_request.onetime = master_request.onetime
		service_request.first_scheduled = master_request.first_scheduled
		service_request.frequency = master_request.frequency
		service_request.service_week_day = master_request.service_week_day
    	service_request.service_month_day = master_request.service_month_day
    	service_request.first_scheduled = master_request.first_scheduled

    	return service_request
	end

	def linkRequests(master_request, service_request)
		service_request.update_attribute(:master_service_request_id, master_request.id)
		master_request.update_attribute(:active_request_id, service_request.id)
	end

end
