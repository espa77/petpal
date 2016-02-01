class Favorite < ActiveRecord::Base
  belongs_to :user
  has_many :users
  has_attached_file :page_avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/pet-community-photo.jpg"
  acts_as_votable
end
