class PropertiesController < ApplicationController
	filter_resource_access
	before_filter :correct_user, only: [:destroy, :edit, :update]

	def create
		@property = current_user.properties.build(params[:property])
		Service::CATEGORIES.count.times do 
			@property.assignments.build
		end

		#respond_to do |format|
	    #  	if @property.save
	    #    	format.html { flash[:succes] = 'Property created.' 
	    #    					redirect_to root_path }
	    #    	format.json { render json: @property, status: :created, location: @property }
	    #  	else
	    #    	format.html { render action: "new" }
	    #    	format.json { render json: @property.errors, status: :unprocessable_entity }
	    #    	format.js {render 'new_modal_error'}
	    #  	end
	    # end
		if @property.save
			flash[:success] = "Property created."
			redirect_to root_path
		else
			flash[:error] = "Couldn't create property at this time. Please try again later."
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
    
	    #respond_to do |format|
	    #	if @property.update_attributes(params[:property])
	 	#     	format.html { redirect_to root_path, notice: "Successfully updated property."}
	 	#     	format.json { head :no_content }
	    #	else
	    #  		format.html { render action: "edit", notice: "Couldn't update property." }
	    #  		format.json { render json: @property.errors, status: :unprocessable_entity }
	    #	end
	    #end
	    if @property.update_attributes(params[:property])
	      flash[:success] = "Successfully updated property."	      
	      redirect_to root_path	    
	    else
	      flash[:error] = "Couldn't update property at this time. Please try again later."
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

	private 
		def correct_user
			@property = current_user.properties.find_by_id(params[:id])
			redirect_to root_path if @property.nil?
		end
end
