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

  def followers
    @followers = @user.followers
    render :friends
  end

  def following
    @following = @user.following
    render :friends
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