class UsersController < ApplicationController

  before_action :check_login
  before_action :get_user, only: [:show, :profile]
  load_and_authorize_resource param_method: :user_params

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

  private

  def user_params
    params.require(:user).permit() if params[:user].present?
  end

  def get_user
    if params[:id].blank? || params[:id] == 'me' || params[:id] == current_user.id
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end
end
