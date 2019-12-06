class PostReservationDetail
  include ActiveModel::Model 
  include ActiveModel::Validations 
  attr_accessor :reservation_id , :products, :client_id
  #validates :reservation_id, numericality: { only_integer: true, greater_than: 0 }
  validate :validate_items_available
  #validates_presence_of :reservation_id, :products

  def create_detail
    products.map do |prod|
      prod[:quantity].times {
        item = Product.find(prod[:product_id]).items_available.first
        item.reserve!
        ReservationDetail.create!(reservation_id: reservation_id, item_id:item.id, price: item.price)
      }
    end
  end

  private

    def validate_items_available
      products.map do |prod|
        unless Product.exists?(prod[:product_id])
          errors.add(:product_id, "Product #{prod[:product_id]} not exists")
        else
          if Product.find(prod[:product_id]).items_available.count < prod[:quantity]
            errors.add(:quantity, "Not enough stock for product #{prod[:product_id]}")
          end
        end
      end
    end
    
end
