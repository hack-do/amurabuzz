class TweetsController < ApplicationController
  before_action :check_login #,only: [:friends,:profile,:index,:edit]
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def index
    @tweets = current_user.timeline_tweets.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @tweet = Tweet.new

  end

  def edit
  end

  def create
    @tweet = Tweet.new(tweet_params)

      if @tweet.save
        current_user.tweets << @tweet
        current_user.save
        @tweet.create_activity :create, owner: current_user
        redirect_to my_tweets_path('me'), notice: 'Tweet was successfully created.'
      else
        redirect_to :back,notice: "Tweet Unsuccessful"
      end
  end

  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        @tweet.create_activity :update, owner: current_user
        format.html { redirect_to user_tweet_path(current_user,@tweet), notice: 'Tweet was successfully updated.' }
      else
        format.html { render 'edit' }
      end
    end
  end

  def destroy
    # if @tweet.user == current_user
      PublicActivity::Activity.where(recipient_type: "Tweet",recipient_id: @tweet.id).each do |a|
        a.destroy
      end

      PublicActivity::Activity.where(trackable_type: "Tweet",trackable_id: @tweet.id).each do |a|
        a.destroy
      end
      @tweet.really_destroy!

      msg = 'Tweet deleted successfully'
    # else
      # msg = 'Permission denied !'
    # end
   redirect_to user_tweets_url(current_user),:notice => msg
  end

    def vote
      @value = params[:type] == "Like" ? 1 : 0
      @tweet = Tweet.find(params[:id])

      @tweet.add_or_update_evaluation(:votes, @value, current_user)
      if @value == 1
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
      tid = params[:tweet_id]
      @tweet = Tweet.find(tid)
      @likers_ids = RsEvaluation.where(target_id: tid, value: 1.0).map{|rs| rs.source_id }
      @likers = []
      @likers_ids.each do |l_id|
          @likers << User.find(l_id)
      end
    end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      # @tweet = Tweet.find(params[:id])
      @tweet = current_user.tweets.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:content,:tweet)
    end
end
