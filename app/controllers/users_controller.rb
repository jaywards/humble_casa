class UsersController < ApplicationController
  filter_resource_access

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
  end

  def show
    @user = User.find(params[:id])
  end


  def update
    #@user = current_user
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
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end


end
