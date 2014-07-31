# encoding: utf-8
class User < ActiveRecord::Base
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
    u = []
    u << self.id
    u << self.following_ids
    Tweet.where(user_id: u.flatten)
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
      user.avatar =  open(auth.info.image,:allow_redirections => :all)#, allow_unsafe_redirects: true)
      #{}"https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xap1/t1.0-1/c0.0.50.50/p50x50/1475882_10202951255481270_75787339_n.jpg"
      #auth.info.image.gsub("­http","htt­ps") # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

 def to_param
    "#{email}".parameterize
  end
end
