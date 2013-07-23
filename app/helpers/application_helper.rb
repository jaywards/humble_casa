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

	
	def spawnServiceRequest(master_request, assignee)
		
		@service_request = ServiceRequest.new(params[:service_request])
		@service_request = updateServiceRequest(@service_request, master_request)
		if assignee.nil?
			@service_request.build_work_assignment
			@service_request.assigned = false
		else
			@service_request.build_work_assignment(user_id: assignee.id)
			@service_request.assigned = true
		end
		@service_request.completed = false
		@service_request.location_verified = false
		@service_request.timestamp_verified = false
		@service_request.build_location

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
    	service_request.all_assigned = master_request.all_assigned

    	return service_request
	end

	def linkRequests(master_request, service_request)
		service_request.update_attribute(:master_service_request_id, master_request.id)
		master_request.update_attribute(:active_request_id, service_request.id)
	end


	def nextScheduled(master_request)
		@today = Date.today
		@frequency = master_request.frequency

		case @master_request.frequency
			when "weekly"
				@next_scheduled = master_request.first_scheduled + 1.week
			when "every_other_week"
				@next_scheduled = master_request.first_scheduled + 2.weeks
			when "monthly"
				@next_scheduled = master_request.first_scheduled + 1.month
			when "every_other_month"
				@next_scheduled = master_request.first_scheduled + 2.months
		end
		return @next_scheduled
	end
end
