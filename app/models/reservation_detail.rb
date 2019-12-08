class ReservationDetail < ApplicationRecord
  belongs_to :item
  belongs_to :reservation

  validates :item_id, :reservation_id, numericality: { only_integer: true, greater_than: 0 }
end
