class UsersController < ApplicationController

  before_action :check_login
  before_action :get_user,only: [:show,:profile,:home]

  def profile
  end

  def index
      @users = User.search(params[:search])
  end

  def show
    # @tweets = @user.tweets.page(params[:page]).per(10)
    @tweets = current_user.timeline_tweets.page(params[:page]).per(10)
    
    respond_to do |format|
      format.html { render 'tweets/_index' }
      format.json { render json: @user }
    end
  end

  def followers
    @followers = current_user.followers
    render :friends
  end

  def following
    @following = current_user.following
    render :friends
  end

  def follow
    respond_to do |format|
      if current_user.follow!(params[:followed_id])
        format.html { redirect_to :back, notice: msg }
        format.json { render json: @user }
      else
        format.html { render action: "new" }
        format.json { render json: 'Invalid operation', status: :unprocessable_entity }
      end
    end
  end

   def unfollow
    respond_to do |format|
      if current_user.unfollow!(params[:followed_id])
        format.html { redirect_to :back, notice: msg }
        format.json { render json: @user }
      else
        format.html { render action: "new" }
        format.json { render json: 'Invalid operation', status: :unprocessable_entity }
      end
    end
  end

  def notifications
      @activities = PublicActivity::Activity.where(owner_id: current_user.following_ids).order("created_at desc")
      @my_activities = PublicActivity::Activity.where(owner_id: current_user.id).order("created_at desc")
  end  

  private
   
  def user_params
    params.require(:user).permit(:avatar_file_name , :avatar_content_type , :avatar_file_size, :avatar_updated_at,:avatar)
  end

  def get_user
    if params[:user_id].nil? || params[:user_id] == 'me' || params[:user_id] == current_user.id
      @user = current_user
    else
      @user = User.find(params[:user_id])
    end
  end

end