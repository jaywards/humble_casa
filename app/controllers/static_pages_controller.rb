class StaticPagesController < ApplicationController
  USER_NAME, PASSWORD = "humble", "house"
  before_filter :authenticate
  
  def home
    @user = current_user
    
    if !current_user.nil?
      
      if @user.role == "propertyowner"

        @property = @user.properties.build
        @property_listings = @user.user_properties
    
      elsif @user.role == "serviceowner"

        @business = @user.business
        if !@business.nil?
          @zips_list = @business.service_servicezips
          @employees = User.find(Employment.where(:service_id => @business.id, :approved => true).map(&:user_id).uniq) 
          if !(@service_request_listings = @business.service_requests).empty?
            @sorted_service_requests = @service_request_listings.sort_by {|a| a.created_at }
          end
        end
      

      elsif @user.role == "employee"
        
        @employer = @user.services.first
        if !@employer.nil?
          if !(@service_request_listings = @user.service_requests).empty?
            @sorted_service_requests = @service_request_listings.sort_by {|a| a.created_at }
          end
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

  private
    def authenticate
      authenticate_or_request_with_http_basic do |user_name, password|
        user_name == USER_NAME && password == PASSWORD
      end
    end
end
