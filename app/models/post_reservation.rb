class PostReservation
  include ActiveModel::Model 
  include ActiveModel::Validations 
  attr_accessor :client_id, :products
  validates :client_id, numericality: { only_integer: true, greater_than: 0 }
  validates_presence_of :client_id, :products
  validate :validate_items_available, :validate_exist_client


  def create_reservation(user)
    Reservation.create!(client_id: client_id, user_id: user)
  end


  private

    def validate_items_available
      products.map do |prod|
        unless Product.exists?(prod[:product_id]) 
          errors.add(:product_id, "Couldn't find Product with 'id'=#{prod[:product_id]}")
        else
          if Product.find(prod[:product_id]).items_available.count < prod[:quantity].to_i
            errors.add(:quantity, "Not enough stock for Product 'id'=#{prod[:product_id]}")
          end
        end
      end
    end

    def validate_exist_client
      unless Client.exists?(client_id)
        errors.add(:client_id, "Couldn't find Client with 'id'=#{client_id}")
      end
    end
end
