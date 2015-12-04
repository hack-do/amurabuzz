class UserObserver < ActiveRecord::Observer
	def after_destroy(user)
		user.activities.destroy_all
	end
end