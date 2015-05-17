class TweetObserver < ActiveRecord::Observer

	def after_create(tweet)
		tweet.create_activity :create, owner: tweet.user
	end

	def after_update(tweet)
		tweet.create_activity :update, owner: tweet.user
	end

	def after_destroy(tweet)
        PublicActivity::Activity.where(recipient_type: "Tweet",recipient_id: tweet.id).each do |a|
          a.destroy
        end
	end

end