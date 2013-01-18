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
end
