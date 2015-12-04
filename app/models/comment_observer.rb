class CommentObserver < ActiveRecord::Observer
	def after_create(comment)
		comment.create_activity :create, owner: comment.user, recipient: comment.tweet
	end
	def after_update(comment)
		comment.create_activity :update, owner: comment.user, recipient: comment.tweet
	end
	def after_destroy(comment)
		comment.create_activity :destroy, owner: comment.user, recipient: comment.tweet
	end
end
