class UserController < ApplicationController
  def friend_profile
  @user=User.find(params[:id])
  @tweets=@user.tweets.paginate(:per_page => 10,:page => params[:page])
end


  def profile
  end

  def friends
    @followers = current_user.followers
    @following = current_user.following
  end

  def all_users
    @users = User.find(:all, :conditions => ["id != ?", current_user.id])
  end

  def follow
    puts "\n\nFollowed ID - #{params[:followed_id]}----------\n\n"
    puts "\n\nCurrent User ID - #{current_user.id}----------\n\n"
    #current_user.follow!(params[:followed_id])
    @followed_id = params[:followed_id] 
    respond_to do |format|
    if current_user.id.to_i != params[:followed_id].to_i 
      if !current_user.following?(params[:followed_id])
        current_user.follow!(params[:followed_id])
        # x = User.find(params[:followed_id])
        # puts x.email
        UserMailerFollow.new_follower(User.find(params[:followed_id]).email,current_user).deliver
        @msg = "Successfull"
        format.html { redirect_to :back, alert: 'User Followed Succesfully !'}
        format.js
      else
        format.html { redirect_to :back,alert: 'Cant follow same User twice' }
        format.js
    end
    else
      @msg = "UnSuccessfull"
      format.html { redirect_to :back, alert: 'Cant follow self'}
      format.json
      format.js
    end
    end
  end

  def unfollow
    puts "\n\nUnfollowed ID - #{params[:unfollowed_id]}----------\n\n"
    puts "\n\nCurrent User ID - #{current_user.id}----------\n\n"
    

    if current_user.id != params[:unfollowed_id] 
      if current_user.following?(params[:unfollowed_id])
        current_user.unfollow!(params[:unfollowed_id])
        redirect_to :back, alert: 'User Unfollowed Succesfully !'
      else
        redirect_to :back, alert: 'Unfollowed User cant be unfollowed again'
      end
  else
    redirect_to :back, alert: 'Cant follow self'
  end
end
end
