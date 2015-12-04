# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  tweet_id   :integer
#  content    :string(255)
#  active     :boolean          default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :tweet
  belongs_to :user

  validates_presence_of :tweet_id, :user_id, :content

  def ui_json
    to_json(include: [:user])
  end
end
