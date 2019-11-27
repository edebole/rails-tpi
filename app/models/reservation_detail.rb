class ReservationDetail < ApplicationRecord
  belongs_to :item
  belongs_to :reservation
end
