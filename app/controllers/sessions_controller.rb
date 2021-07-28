class SessionsController < ApplicationController
  before_action :ensure_logged_in, only: %i(destroy)
  before_action :ensure_logged_out, only: %i(new create)

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ['Invalid username']
      # render :new
    end
  end

  def destroy
    logout!
    flash[:sucess] = ['You are logged out']
    redirect_to new_session_url
  end

  def new
    @user = User.new
    # render :new
  end

end
