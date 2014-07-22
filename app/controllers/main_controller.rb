class MainController < ApplicationController
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
