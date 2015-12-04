class TweetsController < ApplicationController
  include ActionController::Live

  before_action :check_login
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource param_method: :tweet_params

  def index
    @tweets = current_user.timeline_tweets.includes(:user, :votes, :comments, :shares)
    @tweets = @tweets.page(params[:page]).per(10)

    respond_to do |format|
      format.html {}
      format.json { render json: @tweets }
      format.js
    end
  end

  def search
  end

  def show
    respond_to do |format|
      format.html {}
      format.json { render json: @tweet }
    end
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to user_path, notice: 'Tweet was successfully created.' }
        format.json { render json: @tweet }
        format.js
      else
        format.html { redirect_to :back,notice: "Tweet Unsuccessful" }
        format.json { render json: @tweet.errors.full_messages, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @tweet.update_attributes(tweet_params)
        format.html { redirect_to user_tweet_path(current_user,@tweet), notice: 'Tweet successfully updated.' }
        format.json { render json: @tweet }
        format.js
      else
        format.html { render action: 'edit' }
        format.json { render json: @tweet.errors.full_messages, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @tweet.active = false
    @tweet.save

    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: 'Tweet successfully deleted.' }
      format.json { render json: @tweet }
    end
  end

  def add_picture
    @picture = @tweet.pictures.build
    @picture.folder = params[:folder]
    @picture.image_type = params[:image_type]
    @picture.file = params[:attachment].first

    respond_to do |format|
      if @picture.save
        format.json { render :json => @picture, status: :created }
      else
        format.json { render :json => {:errors => @picture.errors.full_messages} }
      end
    end
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:content) if params[:tweet].present?
  end
end
