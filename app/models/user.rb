class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
<<<<<<< HEAD
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable, :confirmable
=======
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable#, :confirmable
>>>>>>> 25a213bf745824af8a35ea8ccd8a92cff48c8f2e

  has_many :tweets,:dependent => :destroy   

  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed


  has_many :reverse_relationships, :foreign_key => "followed_id", :class_name => "Relationship", :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower

  validates_presence_of :first_name, :last_name,:user_name
  validates :bio,length:{ maximum: 160}
  validates :user_name, uniqueness: true

  def following?(followed)
	   relationships.find_by_followed_id(followed)
  end

#current_user.relationships << Relationships.create(:followed_id => followed.id)

  def follow!(followed_id)
	   relationships.create!(:followed_id => followed_id)
  end

  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end

  def timeline_tweets(tweets)
  following.each do |t|
        tweets = tweets + t.tweets 
      end
  end

end
