class ActivitiesController < ApplicationController
	before_action :check_login

	def index
    @my_activities = current_user.activities
    @friends_activities = current_user.friends_activities
    @activities = {me: @my_activities, others: @friends_activities}

    respond_to do |format|
      format.html {}
      format.json { render json: @activities }
      format.js {}
    end
	end
end
