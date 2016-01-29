class Post < ActiveRecord::Base
  belongs_to :user
  mount_uploader :attachment, AvatarUploader
  acts_as_commentable
end
