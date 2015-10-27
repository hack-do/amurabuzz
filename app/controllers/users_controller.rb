class UsersController < ApplicationController

  before_action :check_login
  before_action :get_user,only: [:show,:profile,:home,:followers,:following]

  def index
      @users = User.search(params[:search])
  end

  def show
    @tweets = @user.timeline_tweets.page(params[:page]).per(10)
    respond_to do |format|
      format.html { render 'tweets/_index' }
      format.json { render json: @user }
    end
  end

  def profile
  end

  def friends
    friends = current_user.friends.as_json
    friend_ids = friends.map{|f| f["id"]}

    @redis = Redis.new
    online_friends = @redis.hmget("users",friend_ids)
    puts "online_friends #{online_friends}"
    friends.each_with_index do |friend, i|
      friend["online"] = online_friends[i].present? ? true : false
    end

    respond_to do |format|
       format.json { render json: JSON.parse(friends.to_json) }
    end
  end

  def followers
    @followers = @user.followers
    respond_to do |format|
      format.html { render :friends }
      format.json { render json: @followers }
      format.js
    end
  end

  def following
    @following = @user.following
    respond_to do |format|
      format.html { render :friends }
      format.json { render json: @followers }
      format.js
    end
  end

  def relate
    respond_to do |format|
      if ['follow','unfollow'].include?(params[:type]) && current_user.send(params[:type],params[:followed_id])
        format.html { redirect_to :back, notice: 'User followed successfully' }
        format.json { render json: @user }
      else
        format.html { redirect_to :back }
        format.json { render json: 'Invalid operation', status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar_file_name , :avatar_content_type , :avatar_file_size, :avatar_updated_at,:avatar) if params[:user].present?
  end

  def get_user
    if params[:id].blank? || params[:id] == 'me' || params[:id] == current_user.id
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end

end