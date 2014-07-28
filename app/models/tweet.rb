class Tweet < ActiveRecord::Base
  	belongs_to :user
  	validates :content, :presence => true, :length => { :maximum => 160 }
	#validates :user_id, :presence => true
	default_scope { order("tweets.created_at DESC")}
	  paginates_per 10
end
