class StaticPagesController < ApplicationController

  def home
    @user = current_user
    
    @property = @user.properties.build if !current_user.nil?
    @property_listings = @user.user_properties if !current_user.nil?
    
    @service = @user.services.build if !current_user.nil?
    @service_listings = @user.user_services if !current_user.nil?
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
