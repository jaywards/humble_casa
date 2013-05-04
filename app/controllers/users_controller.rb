class UsersController < ApplicationController
  filter_resource_access

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Successfully created user."
      redirect_to root_path
    else
      flash[:error] = "Couldn't create user."
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def show
    @user = current_user
    #@property = @user.properties.build if !current_user.nil?
    #@property_listings = @user.user_properties
  end


  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:success] = "Successfully updated user."
      redirect_to root_path
    else
      flash[:error] = "Couldn't update user."
      render :action => 'edit'
    end
  end
end
