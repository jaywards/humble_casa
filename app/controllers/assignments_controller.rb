class AssignmentsController < ApplicationController
	
	def provide_estimate
		@assignment = Assignment.find_by_id(params[:id])
		@service = Service.find_by_id(@assignment.service_id)
		@property = Property.find_by_id(@assignment.property_id)
	end


  def confirm_assignment
    @assignment = Assignment.find_by_id(params[:id])
    @service = Service.find_by_id(@assignment.service_id)
    @property = Property.find_by_id(@assignment.property_id)
  end


	def update
  	@assignment = Assignment.find_by_id(params[:id])
    if @assignment.update_attributes(params[:assignment])
    	flash[:success] = "Successfully updated."
    	redirect_to root_path
  	else
    	flash[:error] = "Couldn't save your update. Please try again."
    	redirect_to root_path
    end
  end
end
