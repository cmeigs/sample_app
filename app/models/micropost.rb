class Micropost < ActiveRecord::Base
  # default attr_accessible from scaffolding
  # attr_accessible :content, :user_id
  # remove :user_id and use foreign key relationshipt to user model
  attr_accessible :content

  # creation of foreign key to user.rb
  belongs_to :user

  # Validation
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  # default sort order
  default_scope order: 'microposts.created_at DESC'

  # Returns microposts from the users being followed by the given user.
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (:followed_user_ids) OR user_id = :user_id",
          followed_user_ids: followed_user_ids, user_id: user)
  end

end