class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :gen_currents,:instance_new_tweet
  def instance_new_tweet
  		@tweet = Tweet.new
  end

	def gen_currents
	    @ca = action_name
	    @cc = controller_name
	end

  def check_login
     puts"\n\n\n------------Check Login------------\n\n\n"
    unless current_user
      redirect_to new_user_session_path,notice: "Please Sign-in Before Continuing"
    end 
 end

end
