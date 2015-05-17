class ActivitiesController < ApplicationController
	before_action :check_login
  	
  	def index
      	@my_activities = PublicActivity::Activity.where(owner_id: current_user.id).order("created_at desc")
      	@others_activities = PublicActivity::Activity.where(owner_id: current_user.following_ids).order("created_at desc")	  	
		@activities = {me: @my_activities, others: @others_activities}

	  	respond_to do |format|
	      format.html {}
	      format.json { render json: @activities }
	      format.js {}
	    end  
  	end
end
