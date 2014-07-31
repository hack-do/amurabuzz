class Relationship < ActiveRecord::Base

	 #include PublicActivity::Model
  	 #tracked owner: Proc.new{ |controller, model| controller.current_user }
  
  	acts_as_paranoid
	belongs_to :follower, :class_name => "User"
	belongs_to :followed, :class_name => "User"

end
