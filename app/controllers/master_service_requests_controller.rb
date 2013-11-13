class MasterServiceRequestsController < ApplicationController
	filter_resource_access

	def create
		@master_request = MasterServiceRequest.new(params[:master_service_request])
		@service_request = @master_request.spawnServiceRequest(nil)

		if @master_request.save && @service_request.save
			flash[:success] = "Service request created!"
			@service_request.link_to_master(@master_request)
			@service_request.mail_created
			redirect_to root_path
		else
			@service = Service.find_by_id(@master_request.service_id)
			@property = Property.find_by_id(@master_request.property_id)
			flash[:error] = "Service request couldn't be created at this time. Please try again."
			render :action => 'new'
		end

	end

	def new
		@master_request = MasterServiceRequest.new
		@service = Service.find_by_id(params[:service_id])
		@property = Property.find_by_id(params[:property_id])
		@assignment = @property.assignments.find_by_service_id(@service)
	end

	def edit
		@master_request = MasterServiceRequest.find_by_id(params[:id])
		@service = Service.find_by_id(params[:service_id])
		@property = Property.find_by_id(params[:property_id])
	end

	
	def update
	    @master_request = MasterServiceRequest.find_by_id(params[:id])
 		@service_request = ServiceRequest.find_by_id(@master_request.active_request_id)
 		 
	    if @master_request.update_attributes(params[:master_service_request]) 
	    	@service_request.updateServiceRequest(@master_request)
	    	if @service_request.save
	      		flash[:success] = "Successfully updated service request."	      
		      	@service_request.mail_assigned if (@service_request.assigned && !@mailed_assigned) 
			  	@service_request.mail_completed if (@service_request.completed && !@mailed_completed)
		      	redirect_to root_path
		    else
		    	flash[:error] = "Couldn't update your service request at this time. Please try again"
		    	render :action => 'edit'
		    end
	    else
	    	flash[:error] = "Couldn't update your service request at this time. Please try again"
		    render :action => 'edit'
	    end
	end

	def destroy
		@master_request = MasterServiceRequest.find_by_id(params[:id])
		@active_service_request = ServiceRequest.find_by_id(@master_request.active_request_id)
		@master_request.destroy
		@active_service_request.destroy
		flash[:success] = "Service request deleted"	      
		redirect_to root_path
	end

	def index
		@master_requests = MasterServiceRequest.all
	end

	def pause
		respond_to do |format|
      		format.html
      		format.js
    	end
	end

end
