class User < ApplicationRecord
  has_secure_password
  after_initialize :init
  validates :username, uniqueness: true, presence: true

  def update_token(token,time)
    self.token = token
    self.token_created_at = time
    self.save
  end
  def valid_token?
    now = DateTime.now.to_time
    ut = self.token_created_at.to_time
    ((now - ut) / 1.minutes) < 30
  end
  def init
    self.update_token = DateTime.now if self.update_token.nil?
  end
end
