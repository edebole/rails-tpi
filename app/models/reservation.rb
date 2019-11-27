class Reservation < ApplicationRecord
  has_many :reservation_details
  has_many :items, through: :reservation_details
  belongs_to :user
  belongs_to :client
end
