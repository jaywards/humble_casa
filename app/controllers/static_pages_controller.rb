class StaticPagesController < ApplicationController
  #USER_NAME, PASSWORD = "humble", "house"
  #before_filter :authenticate
  
  def home
    @user = current_user
    
    if !current_user.nil?
      
      case @user.role

        when "propertyowner"
          @property_listings = @user.properties.sort_by { |listing| listing.created_at}
          @property_listings.each do |l|
            l.check_status if !l.nil?
          end
        
        when "serviceowner" 
          @business = Service.find_by_owner_id(@user)
          @date = params[:date] ? Date.parse(params[:date]) : Date.today

          if !@business.nil?
            @business.check_status 
            @customers_report = CustomersReport.new(service_id: @business.id)
            @service_requests_report = @business.service_requests_report(params[:options])
            @payments_report = @business.payments_report(params[:options])
            
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
      
        when "employee"
          if !(@employer = @user.employer).nil?
            if !(@service_request_listings = @user.service_requests).empty?
              @sorted_service_requests = @service_request_listings.sort_by {|a| a.created_at }
            end
          end
      
        when "admin"
          @user.services.each do |s|
            s.check_status if !s.nil?
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



  #private
    #def authenticate
     # authenticate_or_request_with_http_basic do |user_name, password|
     #   user_name == USER_NAME && password == PASSWORD
     # end
    #end
end
