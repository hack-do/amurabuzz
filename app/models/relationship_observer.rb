class RelationshipObserver < ActiveRecord::Observer
	def after_create(relationship)
        follower = User.find relationship.follower_id
        followed = User.find(relationship.followed_id)
        
        follower.create_activity :follow, owner: follower, recipient: followed
        if Rails.env.production?
        	FollowMailer.delay(run_at: 1.minute.from_now).new_follower(followed.email,follower)
        end
	end
end