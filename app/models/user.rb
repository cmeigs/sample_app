# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  
  # has_secure_password will allow password and password_confirmation above to not exist in the database 
  # and allow the password string to written to a database field specifically called "password_digest"
  has_secure_password

  # do before recored saves
  before_save { |user| user.email = email.downcase }

  # validate name where not blank and lengh < 50
  validates :name, presence: true, length: { maximum: 50 }
  # regural expression to hold email adddress restraint
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 		
  # validate email where not blank, format = regex above and unique
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # validate password and confirmation
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

end