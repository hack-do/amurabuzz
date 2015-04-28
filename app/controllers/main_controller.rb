class MainController < ApplicationController
  
  def home        
    redirect_to user_path if user_signed_in?

    @total_users = User.count
    @total_tweets = Tweet.count
  end

end
