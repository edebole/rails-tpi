class SellDetail < ApplicationRecord
  belongs_to :item
  belongs_to :sell
end
