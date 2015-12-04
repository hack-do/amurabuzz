class VotesController < ApplicationController
	before_action :check_login
	before_action :set_tweet , only: [:index, :create]

	def index
  	@votes = @tweet.likes.includes(:user)

    respond_to do |format|
			format.html {}
			format.json { render json: @votes.to_json(include: [:user]) }
			format.js
		end
	end

	def create
    respond_to do |format|
			@vote = @tweet.votes.find_or_initialize_by(user: current_user)
			@vote.value = params[:vote][:value]

			if @vote.save
				format.html { redirect_to :back, notice: "Vote posted successfully !" }
				format.json { render json: @tweet }
				format.js
			else
				format.html { redirect_to :back,alert: @vote.errors.full_messages }
				format.json { render json: @vote.errors.full_messages, status: :unprocessable_entity }
				format.js
	    end
    end
	end

	private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
