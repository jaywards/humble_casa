class StaticPagesController < ApplicationController

  def home
    @user = current_user
    
    if !current_user.nil?
      
      if @user.role == "propertyowner"

        @property = @user.properties.build
        @property_listings = @user.user_properties
    
      elsif @user.role = "serviceowner"

        @service = @user.user_service
        if !@service.first.nil?
          @zips_list = @service.first.service_servicezips
          @employees = User.find(Employment.where(:service_id => @service.first.id).map(&:user_id).uniq) 
          @service_request_listings = @service.first.service_requests
          if !@service_request_listings.empty?
            @sorted_service_requests = @service_request_listings.sort_by {|a| a.completed }
          end
        end
      elsif @user.role == "employee"
        
        if !@user.employments.nil?
          #@employer = Service.find_by_id(@user.employments.first.service_id)
        end
      end
    
    end
  
  end

  def help
  end

  def about
  end

  def pricing_plans
  end

  def feature_tour
  end

  def contact_us
  end

  def careers
  end
end
