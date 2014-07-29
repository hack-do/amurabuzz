class Tweet < ActiveRecord::Base
	acts_as_paranoid
  	belongs_to :user
  	validates :content, :presence => true, :length => { :maximum => 160 }
	default_scope { order("tweets.created_at DESC")}
end
