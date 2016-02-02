class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  mount_uploader :attachment, AvatarUploader
  acts_as_commentable
  acts_as_votable

  @@attached_photos=[]

  # def attachments(id_num,attachment)
  #   @@attached_photos << attachment
  #   photos = Hash.new
  #   photos[id_num]={attachments: @@attached_photos}
  #   photos
  # end
end
