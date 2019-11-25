class User < ApplicationRecord
  has_secure_password
  after_initialize :init
  validates :username, uniqueness: true, presence: true

  def update_token(token,time)
    self.token = token
    self.token_created_at = time
    self.save
  end
  
  def init
    self.token_created_at = DateTime.now if self.token_created_at.nil?
  end
end
