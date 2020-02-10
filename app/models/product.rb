class Product < ApplicationRecord
  has_many :items
  validates :unique_code, uniqueness: true
  validates :unique_code, format: { with: /\A(?=(?:.*\d){6})(?=(?:.*[a-zA-Z]){3})^[a-zA-Z\d]*$\z/ , message: "must be contain 3 letters and 6 digits"}, length: { is: 9 }
  validates :description, length: { maximum: 200 }
  validates :detail, length: { maximum: 1000 }
  validates :unit_price,  numericality: { greater_than: 0 }
  validates :unique_code, :description, :detail, :unit_price, presence: true

  ## ClassMethods to search params
  def self.in_stock
    self.limit(25).select{ |p| p.items_available.count > 0 }
  end

  def self.scarce
    self.limit(25).select{ |p| p.items_available.count > 0 and p.items_available.count <= 5}
  end

  def self.all_limit
    self.all.limit(25)
  end

  ## Instance methods
  def items_available
    self.items.where(state: 'disponible')
  end
end
