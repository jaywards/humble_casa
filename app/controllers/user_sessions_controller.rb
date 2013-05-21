class UserSessionsController < ApplicationController
  filter_resource_access
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:success] = "Successfully logged in"
      redirect_to root_url
    else
      flash[:error] = "Couldn't log in."
      render :action => 'new'
    end
  end

  def destroy
    @user_session = UserSession.find(params[:id])
    @user_session.destroy
    flash[:success] = "Successfully logged out"
    redirect_to root_url
  end
end
