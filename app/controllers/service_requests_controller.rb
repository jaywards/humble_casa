class ServiceRequestsController < ApplicationController

	def create
		@service_request = ServiceRequest.new(params[:service_request])
		@service_request.assigned = false
		@service_request.completed = false
		@service_request.work_assignments.build

		if @service_request.save
			flash[:success] = "Service request created!"
			ServiceMailer.service_created(@service_request).deliver
			@service_request.update_attribute(:mailed_created, true)
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
		@property = Property.find_by_id(@service_request.property_id)
		render 'completed_request'

	end

	def edit
		@service_request = ServiceRequest.find_by_id(params[:id])
		@service = Service.find_by_id(@service_request.service_id)
		@property = Property.find_by_id(@service_request.property_id)
	end

	
	def update
	    @service_request = ServiceRequest.find_by_id(params[:id])

	    if @service_request.update_attributes(params[:service_request])
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

	def destroy
		@service_request = ServiceRequest.find_by_id(params[:id])
		@service_request.destroy
		redirect_to root_path
	end

end