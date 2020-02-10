class Reservation < ApplicationRecord
  has_many :reservation_details, dependent: :destroy
  has_many :items, through: :reservation_details
  has_many :products, through: :items
  belongs_to :user
  belongs_to :client
  belongs_to :sell, required: false

  validates :client_id, :user_id, numericality: { only_integer: true, greater_than: 0 }
  validates :client_id, :user_id, presence:true

  ## use for index controller
  def self.not_sell
    self.all.select{ |r| !r.sell? }
  end
  

  def sell?
    !self.sell.nil?
  end

  # create the necessary relationships to create the item reservation detail
  def reserve_items(products)
    products.map do |prod|
      prod[:quantity].to_i.times {
        unless Product.find(prod[:product_id]).items_available.empty?
          item = Product.find(prod[:product_id]).items_available.first
          # El modelo item es el encargado de reservarse y de crear un detalle con sus datos
          item.create_reserve_detail(self.id)
        end
      }
    end
  end

  # create a sale from the current reservation
  def create_sell()
    unless self.sell?
      Sell.create!(
        client_id: self.client_id,
        user_id: self.user_id,
        reservation_id: self.id,
      )
    else
      raise ExceptionHandler::ReservationSold
    end
  end

  def mark_as_sold(sell_id)
    self.sell_id = sell_id
    self.save
  end

  # create the necessary relationships to create the item sell detail
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

  # delete the current reservation and its items become available
  def cancel
    unless self.sell?
      self.items.map do |item|
        item.cancel!
      end
      self.destroy
    else
      raise ExceptionHandler::ReservationSold
    end
  end

end
