class PropertiesController < ApplicationController
	filter_resource_access
	before_filter :correct_user, only: [:destroy, :edit, :update]

	def create
		@property = current_user.properties.build(params[:property])
		if @property.save
			flash[:success] = "Property created!"
			redirect_to root_path
		else
			flash[:error] = "Property couldn't be created."
			render :action => 'new'
		end
	end

	def new
		@property = Property.new
	end

	def destroy
		@property.destroy
		redirect_to root_path
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

	private 
		def correct_user
			@property = current_user.properties.find_by_id(params[:id])
			redirect_to root_path if @property.nil?
		end
end
