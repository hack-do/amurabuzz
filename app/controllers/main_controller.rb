class MainController < ApplicationController
  #before_action :check_login,only: [:timeline,:friends,:profile]
  def home
    @total_users = User.count
    @total_tweets = Tweet.count
    
  end

  def xtra
  end
end
