class SharesController < ApplicationController
	before_action :check_login
	before_action :set_tweet , only: [:index, :create]

	def index
  	@shares = @tweet.shares.includes(:user)

    respond_to do |format|
			format.html {}
			format.json { render json: @shares.to_json(include: [:user]) }
			format.js
		end
	end

  def create
    @new_tweet = current_user.tweets.new(origin: @tweet, content: @tweet.content)

    respond_to do |format|
      if @new_tweet.save
        format.html { redirect_to user_path, notice: 'Tweet was successfully shared.' }
        format.json { render json: @new_tweet }
      else
        format.html { redirect_to :back,notice: "Tweet Unsuccessful" }
        format.json { render json: @new_tweet.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

	private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
