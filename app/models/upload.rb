class Upload < ActiveRecord::Base
  mount_uploader :name, AvatarUploader
end
