class UserObserver < ActiveRecord::Observer
	def after_save(user)
		if user.active_changed? && user.active_change[1] == true
			PublicActivity::Activity.where(owner_type: "User",owner_id: user.id).each do |a|
	       		a.destroy
	     	end
     	end
	end
end