class FriendsController < ApplicationController

  before_action :check_login,only: [:show,:show_all,:profile]

 def check_login
  if !current_user
    redirect_to new_user_session_path,notice: "Please Sign-in Before Continuing"
  end 
 end

  def show
  	@followers = current_user.followers
    @following = current_user.following
  end

  def show_all
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
        UserMailerFollow.new_follower(User.find(params[:followed_id]).email,current_user)
        @msg = "Successful"
        format.html { redirect_to :back, alert: 'User Followed Succesfully !'}
        format.js
      else
        format.html { redirect_to :back,alert: 'Cant follow same User twice' }
        format.js
    end
    else
      @msg = "UnSuccessful"
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

def profile
@user=User.find(params[:id])
@tweets=@user.tweets
end

  private

 	def relation_params
  		params.require(:relationship).permit(:followed_id)
	end
end
