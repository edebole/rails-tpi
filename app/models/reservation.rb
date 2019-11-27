class Reservation < ApplicationRecord
  has_many :reservation_details
  has_many :items, through: :reservation_details
  belongs_to :user
  belongs_to :client

  def products
    self.joins(:items).joins("INNER JOIN products on products.id = items.product_id").group(:product_id, :id).order(:id).count
  end
end
