class UsersController < ApplicationController
  filter_resource_access
  force_ssl if Rails.env.production?

  def new
    if !current_user.nil?
      flash[:error] = "Can't create a new user. You must logout first before creating a new account."
      if current_user.role.to_s == "propertyowner"
        redirect_to root_path(content: "services")
      else
        redirect_to root_path(content: "homeowner")
      end
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.role == "serviceowner" || @user.role == "employee"
      @user.build_employment
    end
 
    if @user.save
      @user.mail_notification
      flash[:success] = "Successfully created user."
      if @user.role == "serviceowner"
        redirect_to new_user_service_path(@user)
      else
        redirect_to new_user_property_path(@user)
      end
    else
      flash[:error] = "Couldn't create user."
      render :action => 'new'
    end
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
  end


  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Successfully updated user."
      redirect_to root_path
    else
      flash[:error] = "Couldn't update user."
      render :action => 'edit'
    end
  end

  def index
    @users = User.all  
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "Account deleted."
    redirect_to root_path
  end

  #def update_referral_list
  #  @zip = params[:zip]
  #  @referral_list = Service.includes(:service_zips).where(:service_active => true, "service_zips.zip" => @zip)
  #  respond_to do |format|
  #    format.html
  #    format.json {render json: @referral_list}
  #  end
  #end
  
end
