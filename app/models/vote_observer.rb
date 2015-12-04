class VoteObserver < ActiveRecord::Observer
	def after_save(vote)
		if vote.value_changed?
			if vote.value == 1
				vote.create_activity :like, owner: vote.user, recipient: vote.tweet
			else
				vote.create_activity :unlike, owner: vote.user, recipient: vote.tweet
			end
		end
	end
end
