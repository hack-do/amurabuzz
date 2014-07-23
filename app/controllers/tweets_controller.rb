class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  def index  
    @tweets = current_user.timeline_tweets.page(params[:page]).per(10)

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

    # respond_to do |format|

      if @tweet.save
        @msg = "Successfull"
        current_user.tweets << @tweet
        current_user.save
        redirect_to user_tweets_path, notice: 'Tweet was successfully created.'
        # format.html { redirect_to tweets_path, notice: 'Tweet was successfully created.' }
        # format.json { render action: 'index', status: :created, location: @tweet }
        # format.js
      else
        @msg = "Unsuccessfull"
        render action: 'new'
        # format.html { render action: 'new' }
        # format.json { render json: @tweet.errors, status: :unprocessable_entity }
        # format.js
      end
    # end
  end

  def update
    puts "\n\nUPDATE action\n\n"
    puts "#{@tweet.inspect}\n\n\n"
    puts "#{tweet_params[:tweet]}\n\n\n"
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to user_tweet_path(current_user,@tweet), notice: 'Tweet was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    puts "\n\n\n#{@tweet.user.inspect}   #{current_user.inspect}\n\n\n"
    if @tweet.user == current_user
      @tweet.destroy
      msg = 'Tweet deleted successfully'
    else
      msg = 'Permission denied !'
    end

   
   redirect_to user_tweets_url(current_user),:notice => msg
  end

  private
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:content,:tweet)
    end
end
