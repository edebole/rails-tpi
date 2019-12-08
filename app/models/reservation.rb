class Reservation < ApplicationRecord
  has_many :reservation_details, dependent: :destroy
  has_many :items, through: :reservation_details
  has_many :products, through: :items
  belongs_to :user
  belongs_to :client
  #belongs_to :sell, required: false

  validates :client_id, :user_id, numericality: { only_integer: true, greater_than: 0 }

  ## use for index controller
  def self.not_sell
    self.all.select{ |r| !r.sell? }
  end
  
  def sell?
    Sell.where({reservation_id: self.id}).exists?
  end

  def reserve_items(products)
    products.map do |prod|
      prod[:quantity].times {
        item = Product.find(prod[:product_id]).items_available.first
        item.reserve!
        ReservationDetail.create!(reservation_id: self.id, item_id:item.id, price: item.price)
      }
    end
  end

  def create_sell()
    sell = Sell.create!(
      client_id: self.client_id,
      user_id: self.user_id,
      reservation_id: self.id,
      sell_date: Time.now,
    )
  end

  def sell_items(sell_id)
    self.items.each do |item|
        item.sell!
        SellDetail.create!(
          item_id: item.id, 
          sell_id: sell_id, 
          price: self.reservation_details.find_by_item_id(item.id).price
        )
    end
  end

end
