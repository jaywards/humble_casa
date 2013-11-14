class UsersController < ApplicationController
  ffilter_resource_access
  force_ssl

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
    @user.build_employment
    if @user.save
      flash[:success] = "Successfully created user."
      case @user.role
        when "serviceowner"
          redirect_to new_user_service_path(@user)
        when "propertyowner"
          redirect_to new_user_property_path(@user)
        when "employee"
          redirect_to select_employer_user_path(@user)
        else
          redirect_to root_path
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

  def update_employer
    if @user.update_attributes(params[:user])
      flash[:success] = "Successfully updated your employer."
      @user.update_attribute(:new_account, false) if @user.new_account == true
      redirect_to root_path
    else
      flash[:error] = "Couldn't update your employer. Please try again."
      render :action => 'select_employer'
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

  def select_employer
  end

end
