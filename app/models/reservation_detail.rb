class ReservationDetail < ApplicationRecord
  belongs_to :item
  belongs_to :reservation
  #combinacion item y re serva unicos
  validates :item_id, :reservation_id, numericality: { only_integer: true, greater_than: 0 }
end
