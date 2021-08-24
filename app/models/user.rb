class User < ActiveRecord::Base

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false}
  validates :password, length: { minimum: 3}, presence: true

  has_secure_password
  def self.authenticate_with_credentials(email, password)
    user = User.where('lower(email) = ?', email.strip.downcase).first
    if user && user.authenticate(password)
      user.authenticate(password)
    else
      nil
    end 
  end

end
