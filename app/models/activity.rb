# == Schema Information
#
# Table name: activities
#
#  id             :integer          not null, primary key
#  trackable_id   :integer
#  trackable_type :string(255)
#  owner_id       :integer
#  owner_type     :string(255)
#  key            :string(255)
#  parameters     :text(65535)
#  recipient_id   :integer
#  recipient_type :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Activity < ActiveRecord::Base

  default_scope { order("activities.updated_at DESC") }

  validates_presence_of :trackable_id, :trackable_type, :owner_id, :owner_type, :key #, :parameters, :recipient_id, :recipient_type
end
