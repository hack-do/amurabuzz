class CommentsController < ApplicationController
	before_action :check_login
	before_action :set_tweet , only: [:index, :create]

	def index
  	@comments = @tweet.comments.includes(:user)

    respond_to do |format|
			format.html {}
			format.json { render json: @comments }
			format.js
		end
	end

	def create
    respond_to do |format|
			@vote = @tweet.comments.build(user: current_user, content: params[:comment][:content])

			if @vote.save
				format.html { redirect_to :back, notice: "Comment posted successfully!" }
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
