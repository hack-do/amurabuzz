class Relationship < ActiveRecord::Base

	 include PublicActivity::Model
  tracked
  
  	acts_as_paranoid
	belongs_to :follower, :class_name => "User"
	belongs_to :followed, :class_name => "User"

end
