class ApplicationController < ActionController::Base
	include CanCan::ControllerAdditions

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def check_login
    unless current_user
      redirect_to new_user_session_path,notice: "Please Sign-in Before Continuing"
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end
