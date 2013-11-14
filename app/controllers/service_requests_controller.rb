class ServiceRequestsController < ApplicationController
	filter_resource_access
	force_ssl

	def show
		@service_request = ServiceRequest.find_by_id(params[:id])
		@service = Service.find_by_id(@service_request.service_id)
		@property = Property.find_by_id(@service_request.property_id)
		render 'service_request_report'
	end

	def destroy
		@service_request = ServiceRequest.find_by_id(params[:id])
		@service_request.destroy
		flash[:success] = "Deleted service request."
	    redirect_to root_path
	end
	
	def view_completed
		@service = Service.find_by_id(params[:service_id])
		@property = Property.find_by_id(params[:property_id])

		if !(@completed_requests = ServiceRequest.where(
			service_id: params[:service_id], 
			property_id: params[:property_id], 
			completed: true)).empty?
			@completed_requests = @completed_requests.sort_by {|a| a.completed_date }
		end
		render action: "view_completed"
	end

	def index
		@service_requests = ServiceRequest.all
	end

	def assign_to_employee
		@service_request = ServiceRequest.find_by_id(params[:id])
		@service = Service.find_by_id(@service_request.service_id)
		@property = Property.find_by_id(@service_request.property_id)
		render action: "assign_to_employee"
	end

	def complete_request
		@service_request = ServiceRequest.find_by_id(params[:id])
		@assignment = @service_request.property.assignments.find_by_service_id(@service_request.service)
		render action: "complete_request"
	end

	def schedule_request
		@service_request = ServiceRequest.find_by_id(params[:id])
		render action: "schedule_request"
	end
	
	def save_with_completed
		@service_request = ServiceRequest.find_by_id(params[:id])
		
		if @service_request.update_attributes(params[:service_request]) 
			@service_request.process_photos if !@service_request.service_photo_1.current_path.nil?
			@service_request.create_next if !@service_request.onetime
		
			if @service_request.create_charge
				flash[:success] = "Successfully updated service request."
				@service_request.mail_completed
      		else
				flash[:error] = "Unable to charge the customer at this time. HumbleCasa will notify you when this is corrected."
			end
			redirect_to root_path
			
   		else
      		flash[:error] = "Couldn't complete this service request. Please try again."
      		render :action => 'complete_request'
	    end
	end

	def update
		@service_request = ServiceRequest.find_by_id(params[:id])
		@master_request = MasterServiceRequest.find_by_id(@service_request.master_service_request_id)
		
	    if @service_request.update_attributes(params[:service_request]) 
	    	
			if @master_request.all_assigned != @service_request.all_assigned
		      	@master_request.update_attribute(:all_assigned, @service_request.all_assigned)
			end

			if @master_request.all_scheduled != @service_request.all_scheduled
				@master_request.update_attributes(:all_scheduled => @service_request.all_scheduled, 
					:duration => @service_request.duration, :first_scheduled => @service_request.first_scheduled)
			end
	
			flash[:success] = "Successfully updated service request."
	      	@service_request.mail_assigned if (@service_request.assigned && !@service_request.mailed_assigned) 
	      	@service_request.mail_scheduled if (@service_request.scheduled && !@service_request.mailed_scheduled)	      		
	        redirect_to root_path
		else	      
	      	flash[:error] = "Couldn't update service request."
	      	render :action => 'edit'
		end
	end
end
