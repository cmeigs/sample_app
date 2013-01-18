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

  # creation of foriegn key to micropost
  # "dependent: :destroy" means that if we destroy the user that all microposts belonging will also be destroyed
  has_many :microposts, dependent: :destroy
  
  # do before recored saves
  before_save { |user| user.email = email.downcase }    # make sure email is lower-case
  before_save :create_remember_token                    # create a remember token for cookie

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

  def feed
    # This is preliminary. See "Following users" for the full implementation.
    Micropost.where("user_id = ?", id)
  end
  
  # private methods
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end