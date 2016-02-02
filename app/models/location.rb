class Location < ActiveRecord::Base
  has_many :users, through: :user_locations
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
end
