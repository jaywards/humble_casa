class ServiceRequestsController < ApplicationController

	def create
		@service_request = ServiceRequest.new(params[:service_request])
		@service_request.work_assignments.build
		
		if @service_request.save
			flash[:success] = "Service request created!"
			redirect_to root_path
		else
			flash[:error] = "Service request couldn't be created."
			render :action => 'new'
		end

	end

	def new
		@service_request = ServiceRequest.new
		@service = Service.find_by_id(params[:service_id])
		@property = Property.find_by_id(params[:property_id])

	end

	def show
		@service_request = ServiceRequest.find_by_id(params[:id])
		@service = Service.find_by_id(@service_request.service_id)
		@property = Property.find_by_id(@service_request.service_id)

	end

	def edit
		@service_request = ServiceRequest.find_by_id(params[:id])
		@service = Service.find_by_id(@service_request.service_id)
		@property = Property.find_by_id(@service_request.service_id)
	end

	
	def update
	    @service_request = ServiceRequest.find_by_id(params[:id])
	    if @service_request.update_attributes(params[:service_request])
	      flash[:success] = "Successfully updated service request."
	      redirect_to root_path
	    else
	      flash[:error] = "Couldn't update service request."
	      render :action => 'edit'
	    end
	end

	def destroy
		@service_request = ServiceRequest.find_by_id(params[:id])
		@service_request.destroy
		redirect_to root_path
	end

end
