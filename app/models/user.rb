class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts
  has_many :comments
  has_many :requests
  #creates friendship relationship
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :favorites
  #creates inverse friendship relationship
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  #user location joint table relationship
  has_many :user_locations
  has_many :locations, through: :user_locations

  has_attached_file :avatar, styles: { small: "200x200>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/pet-default.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 5.megabytes

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  acts_as_voter


  @@photo_array=[]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      # user.avatar = auth.info.image # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def all_photos
    self.posts.each do |post|
      if post.attachment.present?
        @@photo_array=post.attachment
      end
      @@photo_array
    end
  end

  def display_photos
    all_photos.reverse
  end

  def my_friends
    friends = []
    self.friends.each do |friend|
      friends << friend
    end
    self.inverse_friends.each do |friend|
      friends << friend
    end
    friends
  end

  def find_friendship(unfriender, friend)
    Friendship.all.each do |friendship|
      if (friendship.user_id == friend.id && friendship.friend_id == unfriender.id) || (friendship.user_id == unfriender.id && friendship.friend_id == friend.id)
        my_friendship = friendship
        return my_friendship
      end
    end
  end

end
