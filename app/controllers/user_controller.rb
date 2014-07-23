class UserController < ApplicationController
  def friend_profile
  @user=User.find(params[:id])
  @tweets=@user.tweets.page(params[:page]).per(10)
  end

  def profile
  end

  def friends
    @followers = current_user.followers
    @following = current_user.following
  end

  def all_users
    @users = User.all(:conditions => ["id != ?", current_user.id])
  end

  def follow
    msg = current_user.follow!(current_user,params[:followed_id])

    respond_to do |format|
      format.html { redirect_to :back, alert: msg }
      format.js
    end
  end

  def unfollow
    # puts "\n\nUnfollowed ID - #{params[:unfollowed_id]}----------\n\n"
    # puts "\n\nCurrent User ID - #{current_user.id}----------\n\n"
    
    msg = current_user.unfollow!(current_user,params[:unfollowed_id])
    
    respond_to do |format|
      format.html { redirect_to :back, alert: msg }
      format.js
    end
  end
end
