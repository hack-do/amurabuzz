class TweetsController < ApplicationController
  include ActionController::Live
  helper :emoji

  before_action :check_login
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def index
    @tweets = current_user.timeline_tweets.page(params[:page]).per(10)

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
      else
        format.html { redirect_to :back,notice: "Tweet Unsuccessful" }
        format.json { render json: @tweet.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to user_tweet_path(current_user,@tweet), notice: 'Tweet successfully updated.' }
        format.json { render json: @tweet }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tweet.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @tweet.user == current_user
        @tweet.active == false
        @tweet.save

        format.html { redirect_to user_path(current_user), notice: 'Tweet successfully deleted.' }
        format.json { render json: @tweet }
      else
        format.html { render action: 'edit' }
        format.json { render json: 'Permission denied !', status: :unprocessable_entity }
      end
    end
  end

  def stream
    response.headers['Content-Type'] = 'text/event-stream'
    sse = Stream::SSE.new(response.stream)

    begin
      puts "Creating Stream !!!!!!!!".bold.red
      # sse.write({ :message => "My first sse !" })
      sse.write({name: 'Test'}, event: "event_name")
    rescue IOError
    ensure
      sse.close
    end
  end

  # def stream
  #   response.headers['Content-Type'] = 'text/event-stream'
  #   10.times {
  #       response.stream.write "hello world\n"
  #       sleep 1
  #     }
  # end

  private
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:content) if params[:tweet].present?
    end
end
