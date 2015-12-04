class RelationshipsController < ApplicationController
	before_action :check_login
  before_action :get_user #,only: [:friends, :followers, :following]

  def friends
    @friends = current_user.friends
    @friends = @friends.map{|f| f.ui_json}

    respond_to do |format|
       format.json { render json: @friends }
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

  def follow
    respond_to do |format|
      if current_user.follow(params[:followed_id])
        format.html { redirect_to :back, notice: 'User followed successfully' }
        format.json { render json: @user }
      else
        format.html { redirect_to :back }
        format.json { render json: 'Invalid operation', status: :unprocessable_entity }
      end
    end
  end

  def unfollow
    respond_to do |format|
      if current_user.unfollow(params[:followed_id])
        format.html { redirect_to :back, notice: 'User unfollowed successfully' }
        format.json { render json: @user }
      else
        format.html { redirect_to :back }
        format.json { render json: 'Invalid operation', status: :unprocessable_entity }
      end
    end
  end

	private
  def get_user
    if params[:id].blank? || params[:id] == 'me' || params[:id] == current_user.id
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end
end
