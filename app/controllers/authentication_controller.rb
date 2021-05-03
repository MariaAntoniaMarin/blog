class AuthenticationController < ApplicationController
  skip_before_action :authenticate, only: [:create, :new]

  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user
      if @user.authenticate(params[:password])
        log_in @user
        redirect_to current_user
      else
        flash.now[:alert] = "Invalid username/password combination"
        render 'new'
      end
    else
      flash[:alert] = "Could not find User"
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
