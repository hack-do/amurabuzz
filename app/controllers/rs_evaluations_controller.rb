class RsEvaluationsController < ApplicationController
	before_action :check_login

  	def index
	    @tweet = Tweet.find(params[:tweet_id])
    	@likers = @tweet.evaluations
  	end

  	def create
	    @tweet = Tweet.find(params[:tweet_id])
	    respond_to do |format|
		    if @tweet.add_or_update_evaluation(:votes, params[:type], current_user)
				format.html { redirect_to :back,notice: "#{params[:type]}d tweet" }
				format.json { render json: @tweet }
				format.js 
			else
				format.html { redirect_to :back,alert: @tweet.errors.full_messages }
				format.json { render json: @tweet.errors.full_messages }
				format.js
		    end
	    end
  	end
end