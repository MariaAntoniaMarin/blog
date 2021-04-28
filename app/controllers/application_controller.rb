class ApplicationController < ActionController::Base
  include AuthenticationHelper

  before_action :authenticate

  private

  def authenticate
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to root_path
    end
  end
end
