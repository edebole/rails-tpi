class Item < ApplicationRecord
  belongs_to :product
  has_many :reservation_details
  has_many :reservations, through: :reservation_details
  after_initialize :init

  def init
    self.state ||= 'Disponible'
  end
  # current price
  def price
    product.unit_price
  end
end
