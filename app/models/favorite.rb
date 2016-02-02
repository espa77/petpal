class Favorite < ActiveRecord::Base
  belongs_to :user
  has_many :users
  mount_uploader :attachment, AvatarUploader
  has_many :posts
  # has_attached_file :attachment, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/pet-community-photo.jpg"
  # validates_attachment_content_type :attachment, content_type: /\Aimage\/.*\Z/
  # validates_with AttachmentSizeValidator, attributes: :attachment, less_than: 5.megabytes
  acts_as_votable
  acts_as_commentable
end
