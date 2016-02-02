class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :favorite
  has_many :comments
  mount_uploader :attachment, AvatarUploader
  acts_as_commentable
  acts_as_votable
end 
