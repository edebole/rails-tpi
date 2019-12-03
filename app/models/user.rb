class User < ApplicationRecord
  has_secure_password
  validates :username, uniqueness: { case_sensitive: false }, presence: true
  has_many :reservations
  has_many :sells
end
