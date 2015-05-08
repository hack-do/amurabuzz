class TweetsController < ApplicationController
  include ActionController::Live

  before_action :check_login #,only: [:friends,:profile,:index,:edit]
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @tweet = Tweet.new
  end

  def edit
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    respond_to do |format|
      if @tweet.save
        @tweet.create_activity :create, owner: current_user

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
        @tweet.create_activity :update, owner: current_user
        format.html { redirect_to user_tweet_path(current_user,@tweet), notice: 'Tweet was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    if @tweet.user == current_user
      PublicActivity::Activity.where(recipient_type: "Tweet",recipient_id: @tweet.id).each do |a|
        a.destroy
      end

      PublicActivity::Activity.where(trackable_type: "Tweet",trackable_id: @tweet.id).each do |a|
        a.destroy
      end
      @tweet.really_destroy!

      msg = 'Tweet deleted successfully'
    else
      msg = 'Permission denied !'
    end
   redirect_to user_path(current_user),:notice => msg
  end

  def vote
    value = params[:type] == "Like" ? 1 : 0
    @tweet = Tweet.find(params[:id])
    @tweet.add_or_update_evaluation(:votes, value, current_user)
    if value == 1
      @msg = "Liked tweet"
      current_user.create_activity :like, owner: current_user,recipient: @tweet
    else
      @msg = "Unliked tweet"
    end

    respond_to do |format|
      format.html { redirect_to :back,notice: @msg }
      format.js
    end
  end

  def likes
    @tweet = Tweet.find(params[:id])
    @likers = RsEvaluation.where(target_id: params[:id], value: 1.0).map{|rs| User.find(rs.source_id) }
  end

  def stream
    response.headers['Content-Type'] = 'text/event-stream'

    begin
      10.times {
        response.stream.write "hello world\n"
        sleep 1
      }
    rescue IOError
    ensure
      response.stream.close
    end
  end

  def sse
    response.headers['Content-Type'] = 'text/event-stream'

    sse = Stream::SSE.new(response.stream)
    begin
        sse.write({ :message => "My first sse !" }) #{params[:message]}
    rescue IOError
    ensure
      sse.close
    end
  end

  private
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:content,:tweet)
    end
end
