class StaticPagesController < ApplicationController
  #USER_NAME, PASSWORD = "humble", "house"
  #before_filter :authenticate
  
  def home
    @user = current_user
    
    if !current_user.nil?
      
      if @user.role == "propertyowner"

        #@property = @user.properties.build
        @property_listings = @user.properties.sort_by { |listing| listing.created_at}
        @property_listings.each do |l|
          l.check_status
        end
        
      elsif @user.role == "serviceowner"
    
        @business = @user.business
        @business.check_status
        @date = params[:date] ? Date.parse(params[:date]) : Date.today

        #@customers_report = CustomersReport.new(service_id: @business.id)
        #@mtd_services_customer_report = MTDServicesCustomerReport.new(service_id: @business.id)
        
        
        if !@business.nil?
          @customers_report = @business.properties
          @completed_requests = ServiceRequest.where(:service_id => @business.id, :completed => true)
          @mtd_service_customer_report = @completed_requests.where(["completed_date > ?", Date.today.at_beginning_of_month]).sort_by {|a| a.completed_date}
          @mtd_service_employee_report = @mtd_service_customer_report.sort_by { |b| b.user.last_name }

          @zips_list = @business.service_servicezips
          @employees = User.find(Employment.where(:service_id => @business.id, :approved => true).map(&:user_id).uniq) 
          if !(@service_request_listings = @business.service_requests).empty?
            @sorted_service_requests = @service_request_listings.sort_by {|a| a.created_at }
            @srs_with_repeats = view_context.createRepeats(@sorted_service_requests, @date)
            @srs_for_calendar = @srs_with_repeats.group_by {|b| b.first_scheduled.in_time_zone(b.property.time_zone).to_date.to_formatted_s(:db) }
          end
        end
      

      elsif @user.role == "employee"
        
        @employer = @user.employer
        if !@employer.nil?
          if !(@service_request_listings = @user.service_requests).empty?
            @sorted_service_requests = @service_request_listings.sort_by {|a| a.created_at }
          end
        end
      end
    
    else
      @user_session = UserSession.new
    end
  
  end

  def business    
    if current_user.nil?
      @user_session = UserSession.new
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

  def stripe_signup
    @service = current_user.business
    @user = current_user
    if params[:state] == "1234"
      code = params[:code]
      customer = ActiveSupport::JSON.decode(`curl -X POST https://connect.stripe.com/oauth/token -d client_secret=#{ENV['STRIPE_API_KEY']} -d code=#{code} -d grant_type=authorization_code`)
      @service.update_attributes(
        :stripe_access_token => customer['access_token'], 
        :stripe_refresh_token => customer['refresh_token'],
        :stripe_publishable_key => customer['stripe_publishable_key'],
        :stripe_user_id => customer['stripe_user_id'])
    end
  end

  #private
    #def authenticate
     # authenticate_or_request_with_http_basic do |user_name, password|
     #   user_name == USER_NAME && password == PASSWORD
     # end
    #end
end
