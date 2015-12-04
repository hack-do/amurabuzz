# == Schema Information
#
# Table name: tweets
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  active     :boolean          default(FALSE)
#  origin_id  :integer
#

require 'action_view'
class Tweet < ActiveRecord::Base
  include PublicActivity::Common
  include ActionView::Helpers::DateHelper

  belongs_to :user

  has_many :shares, class_name: 'Tweet', foreign_key: "origin_id", dependent: :destroy
  belongs_to :origin, class_name: 'Tweet'

  has_many :images, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :content, presence: true, length: { maximum: 160 }

  default_scope { where(active: true).order("tweets.updated_at DESC")}

  def likes
    self.votes.where(value: 1.0)
  end

  def latest_comments
    self.comments.order("updated_at DESC").limit(5)
  end

  def created_time
    distance_of_time_in_words_to_now(self.created_at)
  end

  def parsed_content
    Twemoji.parse(self.content)
  end

  def ui_json
    to_json(include: [:user, :votes], methods: [:lastest_comments])
  end
end
