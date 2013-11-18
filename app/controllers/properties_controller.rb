class PropertiesController < ApplicationController
	filter_resource_access
	force_ssl
	
	def create
		@property = current_user.properties.build(params[:property])
		Service::CATEGORIES.count.times do 
			@property.assignments.build
		end
		@property.build_location
		@property.location.address = 
			@property.address1 + " " + @property.address2 + ", " + @property.city + ", " + @property.state
			
		if @property.save
			@time_zone = Timezone::Zone.new :latlon => [@property.location.latitude, @property.location.longitude]
			if @property.update_attribute(:time_zone, @time_zone.zone)
				flash[:success] = "Property created."
				redirect_to add_payment_info_property_path(@property)
			else
				flash[:error] = "Property created but there was an issue finding the time zone."
			end
		else
			flash[:error] = "Couldn't create property."
			render action: 'new'
		end

    end

	def new
		@property = Property.new
		@user = current_user
	end

	def destroy
		@property = Property.find_by_id(params[:id])
		@property.destroy
		flash[:success] = "Property deleted"
		redirect_to root_path
	end

	def edit
		respond_to do |format|
      		format.html 
      		format.js
      	end
	end

	def update_with_card
     	if @property.update_attributes(params[:property]) && @property.update_payment_info && @property.create_assignments_customers
	   		flash[:success] = "Successfully updated payment details"	      
			if @property.new_property
				@property.user.update_attribute(:new_account, false)
				@property.update_attribute(:new_property, false)
				redirect_to root_path(message: "welcome")
			else
		    	redirect_to root_path	    
	    	end
    	else
    		flash[:error] = "Couldn't update your payment info at this time. Please try again."
  			render :action => 'edit_payment_info'
  		end
    end

    def update_with_assignments
    	if @property.update_attributes(params[:property]) && @property.create_assignments_customers && @property.remove_invalid_srs
			flash[:success] = "Successfully updated registered service providers."	      
	    	redirect_to root_path	    
		else
			flash[:error] = "Couldn't update your service providers. Please try again."
  			render :action => 'assign_services'
		end
	end

	def update
		if @property.update_attributes(params[:property])
	    	@location = @property.location
	    	@location.address = @property.address1 + " " + @property.address2 + ", " + @property.city + ", " + @property.state
	   	 	if @location.save
		   	 	@time_zone = Timezone::Zone.new :latlon => [@property.location.latitude, @property.location.longitude]
				if @property.update_attribute(:time_zone, @time_zone.zone)	
			      	flash[:success] = "Successfully updated property."	      
		    	  	redirect_to root_path	    
	    		else
					flash[:error] = "Couldn't update property. There was an issue with identifying the correct time zone."
	      			render :action => 'edit'
	    		end
	    	else
	    		flash[:error] = "Couldn't update property. There was an issue with the address provided."
	      		render :action => 'edit'
	      	end
	    else
	      	flash[:error] = "Couldn't update property."
	      	render :action => 'edit'
	    end
	end

	def index
		@properties = Properties.all

		respond_to do |format|
			format.html #index.html.erb
			format.json { render json: @users }
		end
	end

	def assign_services
	end


	def confirm_assignment
		@service = Service.find_by_id(params[:service_id])
		@property = Property.find_by_id(params[:id])
		@assignment = Assignment.find_by_service_id_and_property_id(@service, @property)
	end
	
	def show
		@property = Property.find_by_id(params[:id])
	end

	def add_payment_info
	end

	def edit_payment_info
	end

end
