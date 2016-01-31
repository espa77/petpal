class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => 'User'

  validate :disallow_self_referential_friendship

  def disallow_self_referential_friendship
    if friend_id == user_id
      errors.add(:friend_id, 'cannot add yourself')
    end
  end
end
