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
    @users = User.where(["id != ?",current_user.id]) 
  end

  def follow
    msg = current_user.follow!(params[:followed_id])
    if msg == 'User Followed !'
      UserMailerFollow.delay(run_at: 1.minute.from_now).new_follower(User.find(params[:followed_id]).email,current_user) 
    end
    redirect_to :back, notice: msg
  end

  def unfollow
    msg = current_user.unfollow!(params[:unfollowed_id])
    redirect_to :back, alert: msg
  end

  def notifications
      puts "\n\nNOFICATIONS\n\n"
      @activities = PublicActivity::Activity.where(owner_id: current_user.following_ids).order("created_at desc")
      @my_activities = PublicActivity::Activity.where(owner_id: current_user.id).order("created_at desc")

      # notify = PublicActivity::Activity.order("created_at desc").find_by(trackable_id: current_user.id,key: "user.notify")
      # if notify 
      #   @activities_drawer = @activities.where(["created_at > ?",notify.created_at])
      # else
      #   @activities_drawer = @activities
      # end
      
      # current_user.create_activity :notify


  end
  

private
   
   def user_params
     params.require(:user).permit(:avatar_file_name , :avatar_content_type , :avatar_file_size, :avatar_updated_at,:avatar)
   end

end
