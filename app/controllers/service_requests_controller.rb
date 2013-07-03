class ServiceRequestsController < ApplicationController

	def show
		@service_request = ServiceRequest.find_by_id(params[:id])
		@service = Service.find_by_id(@service_request.service_id)
		@property = Property.find_by_id(@service_request.property_id)
		render 'service_request_report'
	end

	def destroy
		@service_request = ServiceRequest.find_by_id(params[:id])
		@service_request.destroy
		redirect_to root_path
	end

	def assign_to_employee
		@service_request = ServiceRequest.find_by_id(params[:id])
		@service = Service.find_by_id(@service_request.service_id)
		@property = Property.find_by_id(@service_request.property_id)
		render action: "assign_to_employee"
	end

	def complete_request
		@service_request = ServiceRequest.find_by_id(params[:id])
		render action: "complete_request"
	end
	
	def update
		## SHOULD ONLY OCCUR WHEN ASSIGNING TO EMPLOYEE OR COMPLETING REQUEST, 
		## OTHERWISE ALL CHANGES ARE MADE IN MASTER_SERVICE_REQUEST AND PROPOGATE DOWN
	    @service_request = ServiceRequest.find_by_id(params[:id])
	    @assignee = @service_request.work_assignments.first.user_id
		@current_assigned = @service_request.all_assigned
	    @current_completed = @service_request.completed
		@master_request = MasterServiceRequest.find_by_id(@service_request.master_service_request_id)
		@save_success = false

	    if @service_request.update_attributes(params[:service_request]) 
	    	@save_success = true

		    if @current_assigned != @service_request.all_assigned
		      	@master_request.update_attribute(:all_assigned, @service_request.all_assigned)
				
			elsif @current_completed != @service_request.completed

				if @service_request.completed && !@service_request.onetime
					@new_service_request = view_context.spawnServiceRequest(@master_request)
					view_context.linkRequests(@master_request, @new_service_request)

					if @new_service_request.save 	
						
						if @master_request.all_assigned?
						
							@new_workA = WorkAssignment.where(service_request_id: @new_service_request.id)
							@new_work.update_attribute(:user_id, @assignee)
							@new_service_request.assigned = true
							@new_service_request.all_assigned = true
							# SAVE MIGHT BE UNNECESSARY
							if  @new_workA.save 
								@save_success = true 
							else
								@save_success = false
							end
						else						
							@new_service_request.all_assigned = false
						end

						if @new_service_request.save 
							@save_success = true 
						else
							@save_success = false
						end
					end
				end
			end
		else
			@save_success = false
		end

		if @save_success == true
	      	flash[:success] = "Successfully updated service request."
	      	if @service_request.assigned && !@mailed_assigned 
	      		ServiceMailer.service_assigned(@service_request).deliver
	      		@service_request.update_attribute(:mailed_assigned, true) 
	 	    end
	      	if @service_request.completed && !@mailed_completed
		      	@service_request.update_attribute(:completed_date, Time.now) 
		      	ServiceMailer.service_completed(@service_request).deliver
		      	@service_request.update_attribute(:mailed_completed, true)
		    end       
		    redirect_to root_path
	    else
	      flash[:error] = "Couldn't update service request."
	      render :action => 'edit'
		end
	end
end
