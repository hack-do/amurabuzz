# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  value      :float(24)        default(0.0)
#  user_id    :integer
#  tweet_id   :integer
#  active     :boolean          default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#

class Vote < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :tweet
  belongs_to :user

  validates_presence_of :tweet_id, :user_id

  def ui_json
    to_json(include: [:user,:tweet])
  end
end
