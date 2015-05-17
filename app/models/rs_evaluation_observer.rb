
class TweetObserver < ActiveRecord::Observer
	def after_save(rs_evaluation)
		user = User.find(rs_evaluation.source_id)
		tweet = Tweet.find(rs_evaluation.target_id)
		user.create_activity :like, owner: user,recipient: tweet
	end
end