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
	  
	def createRepeats(srs, date)
    	@startdate = date.at_beginning_of_month
    	@enddate = date.at_end_of_month
    	@updatedSRs = []
    	srs.each do |sr|
	        if sr.first_scheduled <= @enddate
		    	if sr.first_scheduled >= @startdate 
		    		@updatedSRs << sr
		    	end
		        if !sr.onetime && !sr.completed
		        	@pastDateRange = false
		        	@scheduledDate = sr.first_scheduled
		         	
		         	while !@pastDateRange
		            	@newSR = sr.dup
		            	@newSR.first_scheduled = nextScheduled(sr.frequency, @scheduledDate)
		            	if @newSR.first_scheduled >= @startdate 
		            		if @newSR.first_scheduled <= @enddate 
		              			@updatedSRs << @newSR
		              			@scheduledDate = @newSR.first_scheduled
		            		else
		              			@pastDateRange = true
		              		end
		            	else
		            		@scheduledDate = @newSR.first_scheduled
		            	end
		          	end
	        	end
	        end
      	end
      return @updatedSRs
    end

    def nextScheduled(frequency, now_scheduled)
		case frequency
	      when "weekly"
	        @next_scheduled = now_scheduled + 1.week
	      when "every_other_week"
	        @next_scheduled = now_scheduled + 2.weeks
	      when "monthly"
	        @next_scheduled = now_scheduled + 1.month
	      when "every_other_month"
	        @next_scheduled = now_scheduled + 2.months
	    end
	    return @next_scheduled
	end

end
