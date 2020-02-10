class SellDetail < ApplicationRecord
  belongs_to :item
  belongs_to :sell
  # the combination keys sell_id and item_id must be unique
  validates_uniqueness_of :sell_id, scope: :item_id
  validates :item_id, :sell_id, numericality: { only_integer: true, greater_than: 0 }
  validates :price, numericality: { greater_than: 0 }
  validates_presence_of :item_id, :sell_id, :price
end
