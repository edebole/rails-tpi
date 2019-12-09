class User < ApplicationRecord
  has_secure_password
  has_many :reservations
  has_many :sells
  validates :username , presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 4, maximum: 25 }
  validates :password, presence: true, length: { minimum: 4 }

  # format: { with: /\A[a-zA-Z0-9]+\Z/ , message: "must contain no spaces or special characters"}
end
