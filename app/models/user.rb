class User < ApplicationRecord
  has_secure_password
  validates_length_of :password, minimum: 8
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def self.authenticate_with_credentials(email, password)
    email = email.strip
    email = email.downcase
    user = User.find_by(email: email)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end
end
