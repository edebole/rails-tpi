class Item < ApplicationRecord
  belongs_to :product
  has_many :reservation_details
  has_many :reservations, through: :reservation_details
  has_many :sell_details
  has_many :sells, through: :sell_details

  validates :state, inclusion: { in: %w(disponible reservado vendido), message: "%{value} is not a valid state" }
  validates :product_id, presence: true, numericality: { only_integer: true, greater_than: 0 }

  # current price
  def price
    product.unit_price
  end

  def create_reserve_detail(reservation_id)
    self.reserve!
    ReservationDetail.create!(reservation_id: reservation_id, item_id:self.id, price: self.price)
  end
  
  def create_sell_detail(sell_id)
    self.sell!
    SellDetail.create!(sell_id: sell_id, item_id:self.id, price: self.price)
  end

  def available?
    self.state == 'disponible'
  end

  include AASM
  # whiny_transitions to not exceptions, return true or false 
  aasm column: "state", whiny_transitions: false do
    state :disponible, initial: true
    state :reservado, :vendido

    event :reserve do
      transitions from: :disponible, to: :reservado
    end

    event :sell do
      transitions from: [:disponible, :reservado], to: :vendido
    end

    event :cancel do
      transitions from: :reservado, to: :disponible
    end
  end

end
