# encoding: utf-8
class User < ActiveRecord::Base
  include PublicActivity::Common
  #tracked
  acts_as_paranoid
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable, :async, :confirmable, :omniauthable, :omniauth_providers => [:facebook]
  has_many :tweets,:dependent => :destroy
  has_many :evaluations, class_name: "RsEvaluation", as: :source
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed

  has_many :reverse_relationships, :foreign_key => "followed_id", :class_name => "Relationship", :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower

  has_attached_file :avatar ,:default_url => "amura.png"
  validates_presence_of :user_name
  validates :bio,length:{ maximum: 160}
  validates :user_name, uniqueness: true

  validates :dob,date: {after: Proc.new {Time.now - 100.years},
                        before: Proc.new {Time.now} } ,on: :edit

   validates_attachment :avatar,:content_type => { :content_type => ["image/jpeg", "image/jpg", "image/png"] },:size => {:in => 0..500.kilobytes}

  def following?(followed)
	   relationships.find_by_followed_id(followed)
  end

  def follow!(followed_id)
    if self.id.to_i != followed_id.to_i
      if !self.following?(followed_id)
        relationships.create!(:followed_id => followed_id)
        self.create_activity :follow, owner: self, recipient: User.find(followed_id)
        msg = 'User Followed !'
      else
        msg = 'Cant follow same User twice'
      end
    else
      msg = 'Cant follow self'
    end
    msg
  end

  def unfollow!(unfollowed_id)
    if self.id != unfollowed_id
      if self.following?(unfollowed_id)
        relationships.find_by_followed_id(unfollowed_id).really_destroy!
        msg = 'User Unfollowed !'
      else
        msg = 'User already unfollowed'
      end
    else
      msg = 'Cant follow self'
    end
  end

  def timeline_tweets
    Tweet.where(user_id: [self.id,self.following_ids].flatten.compact)
  end

  def voted_for?(tweet)
   evaluations.where(target_type: tweet.class,target_id: tweet.id,value: "1.0").present?
 end

  def self.from_omniauth(auth)
    require 'open-uri'
    if auth.info.nickname.nil?
      auth.info.nickname = auth.info.name
    end
    where(auth.slice(:provider, :uid)).first_or_create! do |user|
      user.email = auth.info.email
      pass = Devise.friendly_token[0,20]
      user.password = pass
      user.password_confirmation = pass
      user.provider = auth.provider
      user.uid = auth.uid
      user.user_name = auth.info.nickname
      user.name = auth.info.name   # assuming the user model has a name
      user.avatar =  open(auth.info.image,:allow_redirections => :all)
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email?
      end
    end
  end

end
