class Sell < ApplicationRecord
  has_many :sell_details
  has_many :items, through: :sell_details
  has_many :products, through: :items
  belongs_to :client
  belongs_to :user
  belongs_to :reservation, required: false

  validates :client_id, :user_id, numericality: { only_integer: true, greater_than: 0 }, presence: true

  def self.all_for_user(id_user)
    self.where({user_id: id_user})
  end

  def sell_items(products)
    products.map do |prod|
      prod[:quantity].to_i.times {
        unless Product.find(prod[:product_id]).items_available.empty?
          item = Product.find(prod[:product_id]).items_available.first
          item.create_sell_detail(self.id)
        end
      }
    end
  end

end
