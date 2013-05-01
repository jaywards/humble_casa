class PropertiesController < ApplicationController
	#before_filter :signed_in_user
	before_filter :correct_property, only: [:destroy, :edit, :update]

	def create
		@property = current_user.properties.build(params[:property])
		if @property.save
			flash[:success] = "Property created!"
		else
			flash[:error] = "Property couldn't be created."
		end
		redirect_to current_user
	end

	def new
		@property = Property.new
	end

	def destroy
		@property.destroy
		redirect_to current_user
	end

	def edit
	end

	def update
    if @property.update_attributes(params[:property])
      flash[:success] = "Successfully updated property."
      redirect_to current_user
    else
      flash[:error] = "Couldn't update property."
      render :action => 'edit'
    end
  end

	private 
		def correct_property
			@property = current_user.properties.find_by_id(params[:id])
			redirect_to current_user if @property.nil?
		end
end
