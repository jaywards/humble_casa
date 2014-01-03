class ServicesController < ApplicationController
	filter_resource_access
	force_ssl
	
	def create
		@user = current_user	
		if @user.role == "admin"
			@service = @user.services.build(params[:service])
		else
			@service = @user.build_business(params[:service])
			@user.build_employment if @user.employment.nil?
		end
		@service.build_location
		@service.location.address = @service.address_for_location
    	
		
		if @service.save
			@time_zone = Timezone::Zone.new :latlon => [@service.location.latitude, @service.location.longitude]
			@service.update_attribute(:time_zone, @time_zone.zone)
			flash[:success] = "Business created!"
			if @service.area_service
				redirect_to root_path
			else
				@user.employment.update_attributes(:user_id => @user.id, :service_id => @service.id, :approved => true)
				@service.mail_notification
				redirect_to add_payment_info_service_path(@service)
			end
		else
			flash[:error] = "Business couldn't be created."
			render :action => 'new'
		end
	end

	def new
		@service = Service.new
		@user = current_user
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
		render :text => @service.reputation_for(:ratings).to_s + "|" + @service.biz_description
	end

	def update_with_card
    	if @service.update_attributes(params[:service]) && @service.update_payment_info
	    	flash[:success] = "Successfully updated payment details"	      
			if @service.new_account			
				redirect_to stripe_signup_path
			else
				redirect_to root_path
			end
    	end
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

	def add_employee
	    @service = Service.find(params[:id])
	    @user = User.new
	    @password = (0...8).map { (65 + rand(26)).chr }.join
	end

	def create_employee
		@user = User.new(params[:service][:user])
    	@user.build_employment
    	if @user.save
			@user.update_attribute(:employer_id, @service.id)
        	@user.employment.update_attributes(:approved => true, :service_id => @service.id)
        	flash[:success] = "Successfully created your employee account. An email has been sent to them with their login details. You can begin assigning them work requests immediately."
        	@user.update_attribute(:new_account, false) if @user.new_account == true
        	@user.mail_new_employee
        	@user.mail_notification
        	redirect_to root_path
        else
        	flash[:error] = "Couldn't create your employee. Please try again."
      		render :action => 'add_employee'
        end
	end
	
	def provide_estimate
		@service = Service.find_by_id(params[:id])
		@property = Property.find_by_id(params[:property_id])
		@assignment = Assignment.find_by_service_id_and_property_id(@service, @property)
	end

	def rate
		value = params[:rating]
		@service = Service.find(params[:id])
		@service.add_or_update_evaluation(:ratings, value, current_user)
		redirect_to :back, notice: "Thank you for providing your feedback"
	end

	def add_payment_info
		@user = current_user
	end

	def edit_payment_info
	end

end
