class Reservation < ApplicationRecord
  has_many :reservation_details, dependent: :destroy
  has_many :items, through: :reservation_details
  belongs_to :user
  belongs_to :client
  has_one :sell, required: false

  def products
    self.joins(:items).joins("INNER JOIN products on products.id = items.product_id").group(:product_id, :id).order(:id).count
  end

  ## use for index controller
  def self.not_sell
    self.includes(:sell).where(sells: { reservation_id: nil })
  end
  def sell?
    Sell.where({reservation_id: self.id}).exists?
  end
end
