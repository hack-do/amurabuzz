# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  user_name              :string(40)       not null
#  name                   :string(60)
#  dob                    :date
#  bio                    :text(255)
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  email                  :string(64)       not null
#  encrypted_password     :string(255)      not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  provider               :string(255)
#  uid                    :string(255)
#  active                 :boolean          default(FALSE)
#  role                   :string(255)      default("individual")
#

class User < ActiveRecord::Base
  include PublicActivity::Common

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable, :async, :confirmable, :omniauthable, :omniauth_providers => [:facebook]

  has_many :tweets, dependent: :destroy
  has_many :votes
  has_many :comments

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :pictures, class_name: "Image", as: :imageable, dependent: :destroy

  default_scope -> { where(active: true) }

  validates :name, :user_name, :email, presence: true
  validates :user_name, uniqueness: true
  validates :bio, length:{ maximum: 160}
  validates :dob, date: {after: Proc.new {Time.now - 100.years},
                        before: Proc.new {Time.now} } ,allow_blank: true

  def profile_picture(show_default = true)
    profile_picture = self.pictures.where(image_type: "profile_picture").first
    if profile_picture.blank? && show_default == true
      profile_picture = self.pictures.build(image_type: "profile_picture") # , file: File.open("#{Rails.root}/app/assets/images/amura.png","r")
    end

    profile_picture
  end

  def activities
    PublicActivity::Activity.where(owner_id: self.id)
  end

  def friends_activities
    PublicActivity::Activity.where(owner_id: self.following_ids)
  end

  def self.search(search=nil)
    if search.present?
      where("name LIKE ? OR user_name LIKE ? OR email LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%") #.where.not(id: current_user.id)
    else
      all
    end
  end

  def following?(followed)
	   relationships.find_by_followed_id(followed)
  end

  def follow(followed_id)
    if self.id == followed_id
      raise StandardError, "Cannot follow self"
    end

    if !self.following?(followed_id)
      relationships.create!(:followed_id => followed_id)
    end
  end

  def unfollow(followed_id)
    if self.id == followed_id
      raise StandardError, "Cannot unfollow self"
    end

    if self.following?(followed_id)
      relationships.find_by_followed_id(followed_id).destroy
    end
  end

  def timeline_tweets
    user_ids = self.following_ids.push(self.id).compact
    Tweet.where(user_id: user_ids)
  end

  def voted_for?(tweet)
   votes.where(tweet_id: tweet.id,value: 1.0).present?
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create! do |user|
      user.email = auth.info.email
      pass = Devise.friendly_token[0,20]
      user.password = pass
      user.password_confirmation = pass
      user.provider = auth.provider
      user.uid = auth.uid
      user.user_name = auth.info.nickname.blank? ? auth.info.name : auth.info.nickname
      user.name = auth.info.name   # assuming the user model has a name
      # user.profile_picture = open(auth.info.image,:allow_redirections => :all)
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def friends
    friend_ids = self.follower_ids & self.following_ids
    friend_ids.map{|id| User.find id}
  end

  def ui_json
    as_json(methods: [:online_status, :profile_picture])
  end

  def online_friends
    @redis = Redis.new
    friends = current_user.friends.as_json #(method: [:is_online?])

    online_friends = @redis.hmget("users", self.id)
    friends.each_with_index do |friend, i|
      friend["online"] = online_friends[i].present? ? true : false
    end

    friends
  end

  def online_status
    @redis = Redis.new
    @redis.hget("users", self.id).present?
  end

  def set_online_status(status = true)
    @redis = Redis.new
    @redis.hset("users", self.id, status)
  end

 # def to_param
 #    "#{email}".parameterize
 #  end
end
