class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :instance_new_tweet,:gen_currents
  before_action :check_login,only: [:tweets,:friends]
  def instance_new_tweet
  		@tweet = Tweet.new
  end

	def gen_currents
	    @current_action = action_name
	    @current_controller = controller_name
	end

  def check_login
     puts"\n\n\n------------Check Login------------\n\n\n"
    if !current_user
      redirect_to new_user_session_path,notice: "Please Sign-in Before Continuing"
    end 
 end

end
