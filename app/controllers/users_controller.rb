class UsersController < ApplicationController
  filter_resource_access

  def new
    @user = User.new

  end

  def create
    @user = User.new(params[:user])
    @user.employments.build
    if @user.save
      flash[:success] = "Successfully created user."
      redirect_to root_path
    else
      flash[:error] = "Couldn't create user."
      render :action => 'new' #NEED TO MAINTAIN ROLE PARAMS HERE
    end
  end

  def edit
    @user = current_user
  end

  def show
    @user = current_user
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
