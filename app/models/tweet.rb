class Tweet < ActiveRecord::Base
<<<<<<< HEAD
  	belongs_to :user, polymorphic: true
=======
  	belongs_to :user
>>>>>>> 25a213bf745824af8a35ea8ccd8a92cff48c8f2e
  	validates :content, :presence => true, :length => { :maximum => 160 }
	# validates :user_id, :presence => true
	default_scope { order("tweets.created_at DESC")}
end
