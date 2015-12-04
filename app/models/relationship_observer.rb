class RelationshipObserver < ActiveRecord::Observer
	def after_create(relationship)
		relationship.create_activity :follow, owner: relationship.follower, recipient: relationship.followed

		FollowMailer.delay(run_at: 1.minute.from_now).new_follower(relationship.followed.email,relationship.follower)
	end
end
