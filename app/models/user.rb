class User < ActiveRecord::Base
  before_save { self.email = email.downcase
                self.username = username.downcase }
  validates :username, presence: true, length: { maximum: 20 },
                    uniqueness: { case_sensitive: false }
  VALID_EMAIL_OR_BLANK_REGEX = /\A([\w+\-.]+@[a-z\d\-.]+\.[a-z]+)?\z/i
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_OR_BLANK_REGEX }

  has_secure_password

end
