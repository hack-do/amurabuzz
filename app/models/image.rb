# == Schema Information
#
# Table name: images
#
#  id                :integer          not null, primary key
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  tags              :string(255)
#  description       :string(255)
#  folder            :string(255)
#  image_type        :string(255)
#  imageable_id      :integer
#  imageable_type    :string(255)
#  active            :boolean          default(TRUE)
#  created_at        :datetime
#  updated_at        :datetime
#

class Image < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :imageable, polymorphic: true
  belongs_to :tweet

  has_attached_file :file, {
    preserve_files: "true",
    default_url: "default_user.jpg",
    path: ":rails_root/public/system/:attachment/:id/:style/:filename",
    url: "/system/:attachment/:id/:style/:filename",
    :styles => {
      thumb: "100x100#",
      small: "150x150>",
      medium: "200x200"
    }
  }

  serialize :tags

  validates :image_type, presence: true
	validates_attachment :file, attachment_presence: true, content_type: { content_type: ["image/jpeg", "image/jpg", "image/png"] }, size: { in: 0..5.megabytes }

  default_scope { where(active: true).order("updated_at DESC")}

  def ui_json
    to_json
  end

  def as_json(options={})
    json = super
    json[:file_url] = self.file_url
    json[:thumb_file_url] = self.file_url(:thumb)
    json[:small_file_url] = self.file_url(:small)
    json[:medium_file_url] = self.file_url(:medium)

    return json
  end

  def file_url(type = nil)
    self.file.url(type)
  end
end
