class Tweet < ActiveRecord::Base
 	include PublicActivity::Common

  	has_reputation :votes, source: :user, aggregated_by: :sum
  	belongs_to :user
  	  	
  	validates :content, :presence => true, :length => { :maximum => 160 }
	
	default_scope { where(active: true).order("tweets.updated_at DESC")}
end
