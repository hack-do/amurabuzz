class ImageObserver < ActiveRecord::Observer
	def after_create(image)
		image.create_activity :create, owner: image.imageable, recipient: image.tweet
	end
	def after_update(image)
		image.create_activity :update, owner: image.imageable, recipient: image.tweet
	end
	def after_destroy(image)
		image.create_activity :destroy, owner: image.imageable, recipient: image.tweet
	end
end
