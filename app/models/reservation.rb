class Reservation < ApplicationRecord
  has_many :reservation_details, dependent: :destroy
  has_many :items, through: :reservation_details
  has_many :products, through: :items
  belongs_to :user
  belongs_to :client
  has_one :sell, required: false

  ## use for index controller
  def self.not_sell
    self.includes(:sell).where(sells: { reservation_id: nil })
  end
  def sell?
    Sell.where({reservation_id: self.id}).exists?
  end
end
