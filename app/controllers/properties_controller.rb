class PropertiesController < ApplicationController
	filter_resource_access
	
	def create
		@property = current_user.properties.build(params[:property])
		Service::CATEGORIES.count.times do 
			@property.assignments.build
		end
		@property.build_location
		@property.location.address = 
			@property.address1 + " " + @property.address2 + ", " + @property.city + ", " + @property.state

		if @property.save
			flash[:success] = "Property created."
			redirect_to root_path(message: "welcome")
		else
			flash[:error] = "Couldn't create property."
			render action: 'new'
		end

    end

	def new
		@property = Property.new

		respond_to do |format|
      		format.html # new.html.erb
      		format.json { render json: @property}
    	end
	end

	def destroy
		@property = Property.find_by_id(params[:id])
		@property.destroy
		flash[:success] = "Property deleted"
		redirect_to root_path
	end

	def edit
	end

	def update

	    if @property.update_attributes(params[:property])
	      flash[:success] = "Successfully updated property."	      
	      redirect_to root_path	    
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
		render action: "assign_services"
	end

	def show_property
		@property = Property.find_by_id(params[:id])
		render action: "show_property"
	end

end
