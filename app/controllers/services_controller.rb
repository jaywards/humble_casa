class ServicesController < ApplicationController
	filter_resource_access

def create
		@user = current_user
		@service = @user.build_business(params[:service])
		@service.employments.build
		@service.employments.first.user_id = current_user.id
		@service.employments.first.service_id = @service.id
		if @service.save
			flash[:success] = "Service created!"
			redirect_to root_path(message: "welcome")
		else
			flash[:error] = "Service couldn't be created."
			render :action => 'new'
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

	def update
    if @service.update_attributes(params[:service])
      flash[:success] = "Successfully updated service."
      redirect_to root_path
    else
      flash[:error] = "Couldn't update service."
      render :action => 'edit'
    end
  end

end
