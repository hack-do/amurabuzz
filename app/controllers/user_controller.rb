class UserController < ApplicationController
  def friend_profile
  @user=User.find(params[:id])
   @tweets=@user.tweets.page(params[:page])#.per(10)
  end

  def profile
  end

  def friends
    @followers = current_user.followers
    @following = current_user.following
  end

  def all_users
    @users = User.all(:conditions => ["id != ?", current_user.id])#.paginate(:per_page => 10,:page => params[:page])
      respond_to do |format|
        format.html
        #format.json { render json: UserDatatable.new(view_context) }
      end
  end

  def follow
    msg = current_user.follow!(current_user,params[:followed_id])
    UserMailerFollow.delay({run_at: 1.minute.from_now}).new_follower(User.find(params[:followed_id]).email,current_user)
    #UserMailerFollow.new_follower(User.find(params[:followed_id]).email,current_user)
    
     redirect_to user_all_users_path
    # respond_to do |format|
    # #  format.html { redirect_to :back, notice: msg }
    #   format.js
    # end
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
