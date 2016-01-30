class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts
  has_many :comments
  #creates friendship relationship
  has_many :friendships
  has_many :friends, :through => :friendships
  #creates inverse friendship relationship
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  mount_uploader :profilePic, AvatarUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #  profilePic = Magick::Image.read('/images/fallback/pet-default.jpg')
end
