class PropertiesController < ApplicationController
	filter_resource_access
	before_filter :correct_user, only: [:show, :destroy, :edit, :update]

	def create
		@property = current_user.properties.build(params[:property])
		Service::CATEGORIES.count.times do 
			@property.assignments.build
		end

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
		@property.destroy
		respond_to do |format|
			format.html { redirect_to root_path }
			format.json { head :no_content }
		end
	end

	def edit
		@property = Property.find_by_id(params[:id])

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

	private 
		def correct_user
			@property = current_user.properties.find_by_id(params[:id])
			redirect_to root_path if @property.nil?
		end
end
