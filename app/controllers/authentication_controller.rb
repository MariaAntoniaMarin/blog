class AuthenticationController < ApplicationController
  skip_before_action :authenticate, only: [:create, :new]

  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user
      if @user.authenticate(params[:password])
        log_in @user
        render "users/show"
      else
        flash.now[:danger] = 'Invalid username/password combination'
        render 'new'
      end
    else
      flash.now[:danger] = 'Could not find User'
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
