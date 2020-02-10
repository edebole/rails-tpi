class ReservationDetail < ApplicationRecord
  belongs_to :item
  belongs_to :reservation
  # the combination keys reservation_id and item_id must be unique
  validates_uniqueness_of :reservation_id, scope: :item_id
  validates :item_id, :reservation_id, numericality: { only_integer: true, greater_than: 0 }
  validates_presence_of :item_id, :reservation_id, :price
  validates :price, numericality: { greater_than: 0 }
end
