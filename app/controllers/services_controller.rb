class ServicesController < ApplicationController
	filter_resource_access

def create
		@user = current_user
		@service.user_id = @user.id
		@service = @user.build_business(params[:service])
		@service.build_location
		@service.location.address = 
			@service.address1 + " " + @service.address2 + ", " + @service.city + ", " + @service.state
			
		if @user.employments.empty?
			@service.employments.build
			@service.employments.first.user_id = current_user.id
			@service.employments.first.service_id = @service.id
			@service.employments.first.approved = true

			if @service.save
				@user.employments.first.update_attributes(:user_id => current_user.id, :service_id => @service.id, :approved => true)		
				@time_zone = Timezone::Zone.new :latlon => [@service.location.latitude, @service.location.longitude]
				if @service.update_attribute(:time_zone, @time_zone.zone)
					flash[:success] = "Service created!"
					redirect_to root_path(message: "welcome")
				else
					flash[:error] = "Service created but there was an issue finding the time zone."
					render :action => 'new'
				end
			else
				flash[:error] = "Service couldn't be created."
				render :action => 'new'
			end
		else
			if @service.save
				@user.employments.first.update_attributes(:user_id => current_user.id, :service_id => @service.id, :approved => true)		
				@time_zone = Timezone::Zone.new :latlon => [@service.location.latitude, @service.location.longitude]
				if @service.update_attribute(:time_zone, @time_zone.zone)
					flash[:success] = "Service created!"
					redirect_to root_path(message: "welcome")
				else
					flash[:error] = "Service created but there was an issue finding the time zone."
					render :action => 'new'
				end
			else
				flash[:error] = "Service couldn't be created."
				render :action => 'new'
			end
		end
	end

	def new
		@service = Service.new
		@service.service_zips.build
	end

	def destroy
		@service = Service.find_by_id(params[:id])
		@service.destroy
		flash[:success] = "Business deleted"
		redirect_to root_path
	end

	def edit
	end

	def show
		@service = Service.find_by_id(params[:id])
		render :text => @service.biz_description
	end

	def update
    	if @service.update_attributes(params[:service])
     		@location = @service.location
	    	@location.address = @service.address1 + " " + @service.address2 + ", " + @service.city + ", " + @service.state
	   	 	if @location.save
		   	 	@time_zone = Timezone::Zone.new :latlon => [@service.location.latitude, @service.location.longitude]
				if @service.update_attribute(:time_zone, @time_zone.zone)	
			      	flash[:success] = "Successfully updated service."	      
		    	  	redirect_to root_path	    
	    		else
					flash[:error] = "Couldn't update service. There was an issue with identifying the correct time zone."
	      			render :action => 'edit'
	    		end
	    	else
	    		flash[:error] = "Couldn't update service. There was an issue with the address provided."
	      		render :action => 'edit'
	      	end

	    else
	      flash[:error] = "Couldn't update service."
	      render :action => 'edit'
	    end
  	end

	def approve_employee
	    @service = Service.find(params[:id])
	    @employments = @service.employments.find_all { |x| x.approved == nil } 
	    render action: "approve_employee"
	end

	
	def provide_estimate
		@service = Service.find_by_id(params[:id])
		@property = Property.find_by_id(params[:property_id])
		@assignment = Assignment.find_by_service_id_and_property_id(@service, @property)
	end
end
