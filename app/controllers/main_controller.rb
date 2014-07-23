class MainController < ApplicationController
  before_action :check_login,only: [:timeline,:friends,:profile]
  def home
    @total_users = User.all.count
    @total_tweets = Tweet.all.count
    
  end

  def timeline
  end

  def friends
  end

  def profile
    
  end

  def xtra
  end
end
