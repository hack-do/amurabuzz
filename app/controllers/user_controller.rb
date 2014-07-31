class UserController < ApplicationController

  before_action :check_login
  
  def friend_profile
    @user=User.find(params[:id])
    @tweets=@user.tweets.page(params[:page]).per(10)
  end

  def home
  end

  def profile
  end

  def friends
    @followers = current_user.followers
    @following = current_user.following
  end

  def all_users
    @users = User.all(:conditions => ["id != ?", current_user.id])#.paginate(:per_page => 10,:page => params[:page])
  end

  def follow
    msg = current_user.follow!(current_user,params[:followed_id])
    UserMailerFollow.delay(run_at: 1.minute.from_now).new_follower(User.find(params[:followed_id]).email,current_user) 
    redirect_to :back, notice: msg
  end

  def unfollow
    msg = current_user.unfollow!(current_user,params[:unfollowed_id])
    redirect_to :back, alert: msg
  end

  def notifications
      puts "\n\nNOFICATIONS\n\n"
      @activities = PublicActivity::Activity.all.order("created_at desc").where(owner_id: current_user.following_ids)
      @my_activities = PublicActivity::Activity.all.order("created_at desc").where(owner_id: current_user.id)
  end
  

private
   
   def user_params
     params.require(:user).permit(:avatar_file_name , :avatar_content_type , :avatar_file_size, :avatar_updated_at,:avatar)
   end

end
