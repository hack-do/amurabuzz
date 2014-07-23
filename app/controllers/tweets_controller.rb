class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  def check_login
    puts"\n\n\n------------Check Login------------\n\n\n"
    if !current_user
      redirect_to new_user_session_path,notice: "Please Sign-in Before Continuing"
    end  
  end
 
  def index  
    @tweets = current_user.timeline_tweets.page(params[:page]).per(10)
    puts "\n\n\n\nTimeline Tweets\n#{@tweets.inspect}\n\n\n\n\n\n"
  end

  def show
    puts "\n\nSHOW action\n\n"
  end

  def new
    @tweet = Tweet.new
  end

  def edit
  end

  def create
    puts "\n\nCREATE action\n\n"
    @tweet = Tweet.new(tweet_params)
    respond_to do |format|
      if @tweet.save
        @msg = "Successfull"
        current_user.tweets << @tweet
        current_user.save
        format.html { redirect_to tweets_path, notice: 'Tweet was successfully created.' }
        format.json { render action: 'index', status: :created, location: @tweet }
        format.js
      else
        @msg = "Unsuccessfull"
        format.html { render action: 'new' }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url }
      format.json { head :no_content }
    end
  end

  private
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:content)
    end
end
