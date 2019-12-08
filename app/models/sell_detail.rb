class SellDetail < ApplicationRecord
  belongs_to :item
  belongs_to :sell
  validates :item_id, :sell_id, numericality: { only_integer: true, greater_than: 0 }
end
