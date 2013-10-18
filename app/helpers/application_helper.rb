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

		if master_request.all_scheduled
			@service_request.scheduled = true
		end

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
    	service_request.completed_date = master_request.first_scheduled
    	service_request.paused = master_request.paused
    	service_request.all_assigned = master_request.all_assigned
    	service_request.time_zone = master_request.time_zone
    	service_request.duration = master_request.duration
    	service_request.all_scheduled = master_request.all_scheduled

    	return service_request
	end

	def linkRequests(master_request, service_request)
		service_request.update_attribute(:master_service_request_id, master_request.id)
		master_request.update_attribute(:active_request_id, service_request.id)
	end


	def nextScheduled(frequency, current)
		case frequency
			when "weekly"
				@next_scheduled = current + 1.week
			when "every_other_week"
				@next_scheduled = current + 2.weeks
			when "monthly"
				@next_scheduled = current + 1.month
			when "every_other_month"
				@next_scheduled = current + 2.months
		end
		return @next_scheduled
	end

	def createRepeats(srs, date)
    	@startdate = date.at_beginning_of_month
    	@enddate = date.at_end_of_month
    	@updatedSRs = []
    	srs.each do |sr|
	        if sr.first_scheduled >= @startdate && sr.first_scheduled <= @enddate
		    	@updatedSRs << sr
		    end
	        if !sr.onetime && !sr.completed
	        	@inDateRange = true
	        	@scheduledDate = sr.first_scheduled
	         	while @inDateRange
	            	@newSR = sr.dup
	            	@newSR.first_scheduled = nextScheduled(sr.frequency, @scheduledDate)
	            	if @newSR.first_scheduled >= @startdate 
	            		if @newSR.first_scheduled <= @enddate 
	              			@updatedSRs << @newSR
	              			@scheduledDate = @newSR.first_scheduled
	            		else
	              			@inDateRange = false
	              		end
	            	else
	            		@scheduledDate = @newSR.first_scheduled
	            	end
	          	end
        	end
      	end
      return @updatedSRs
    end
end
