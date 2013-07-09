class MasterServiceRequestsController < ApplicationController
	filter_resource_access

	def create
		@master_request = MasterServiceRequest.new(params[:master_service_request])
		
		@service_request = view_context.spawnServiceRequest(@master_request)

		if @master_request.save && @service_request.save
			flash[:success] = "Service request created!"
			view_context.linkRequests(@master_request, @service_request)
			ServiceMailer.service_created(@master_request).deliver
			@service_request.update_attribute(:mailed_created, true)
			redirect_to root_path
		else
			flash[:error] = "Service request couldn't be created."
			render :action => 'new'
		end
	end

	def new
		@master_request = MasterServiceRequest.new
		@service = Service.find_by_id(params[:service_id])
		@property = Property.find_by_id(params[:property_id])

		respond_to do |format|
      		format.html # new.html.erb
      		format.json { render json: @master_request}
    	end

	end

	#def show
	#	@master_request = MasterServiceRequest.find_by_id(params[:id])
	#	@service = Service.find_by_id(@master_request.service_id)
	#	@property = Property.find_by_id(@master_request.property_id)
	#	render 'completed_request'
	#end

	def edit
		@master_request = MasterServiceRequest.find_by_id(params[:id])
		@service = Service.find_by_id(params[:service_id])
		@property = Property.find_by_id(params[:property_id])
	end

	
	def update
	    @master_request = MasterServiceRequest.find_by_id(params[:id])
 		@service_request = ServiceRequest.find_by_id(@master_request.active_request_id)
 		@service_request = view_context.updateServiceRequest(@service_request, @master_request)
	     
	    if @master_request.update_attributes(params[:master_service_request]) 
	    	@service_request = view_context.updateServiceRequest(@service_request, @master_request)
	    	if @service_request.save
	      		flash[:success] = "Successfully updated service request."	      
	      
		      	if @service_request.assigned && !@mailed_assigned 
			      	ServiceMailer.service_assigned(@master_request).deliver
			      	@service_request.update_attribute(:mailed_assigned, true)
		      	end
			      
		      	if @service_request.completed && !@mailed_completed
			      	ServiceMailer.service_completed(@master_request).deliver
			      	@service_request.update_attribute(:mailed_completed, true)
		      	end       
		      	redirect_to root_path
		      end
	    else
	      flash[:error] = "Couldn't update service request."
	      render :action => 'edit'
	    end
	end

	def destroy
		@master_request = MasterServiceRequest.find_by_id(params[:id])
		@master_request.destroy
		redirect_to root_path
	end

end
