class Tweet < ActiveRecord::Base
	acts_as_paranoid
  	belongs_to :user
  	has_reputation :votes, source: :user, aggregated_by: :sum
  	validates :content, :presence => true, :length => { :maximum => 160 }
	default_scope { order("tweets.updated_at DESC")}
end
