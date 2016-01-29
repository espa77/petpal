class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts
  #creates friendship relationship
  has_many :friendships
  has_many :friends, :through => :friendships
  #creates inverse friendship relationship
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable
  # mount_uploader :avatar, AvatarUploader (unneccessary right now, but might be relevant later?)
end
