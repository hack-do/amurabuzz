class Tweet < ActiveRecord::Base
  	belongs_to :user, polymorphic: true
  	validates :content, :presence => true, :length => { :maximum => 160 }
	# validates :user_id, :presence => true
	default_scope { order("tweets.created_at DESC")}
end
