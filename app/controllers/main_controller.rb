class MainController < ApplicationController

  def home
    @total_users = User.count
    @total_tweets = Tweet.count
    
    if user_signed_in?
    	redirect_to my_home_path('me')
    end

  end

  def xtra
  end
end
