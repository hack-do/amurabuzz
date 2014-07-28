class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable#, :confirmable

  has_many :tweets,:dependent => :destroy   

  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed


  has_many :reverse_relationships, :foreign_key => "followed_id", :class_name => "Relationship", :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower

  has_attached_file :avatar ,:default_url => "amura.png"
  validates_presence_of :user_name
  validates :bio,length:{ maximum: 160}
  validates :user_name, uniqueness: true

  def following?(followed)
	   relationships.find_by_followed_id(followed)
  end

#current_user.relationships << Relationships.create(:followed_id => followed.id)

  def follow!(current_user,followed_id)
    if current_user.id.to_i != followed_id.to_i 
      if !current_user.following?(followed_id)
        relationships.create!(:followed_id => followed_id)
        msg = 'User Followed !'
      else
        msg = 'Cant follow same User twice'
      end
    else
      msg = 'Cant follow self'
    end
    msg
  end

  def unfollow!(current_user,unfollowed_id)
    if current_user.id != unfollowed_id 
      if current_user.following?(unfollowed_id)
        relationships.find_by_followed_id(unfollowed_id).destroy
        msg = 'User Unfollowed !'
      else
        msg = 'User already unfollowed'
      end
    else
      msg = 'Cant follow self'
    end
  end

  def timeline_tweets
    u = []
    u << self.id
    u << self.following_ids
    Tweet.where(user_id: u.flatten)
  end

end
