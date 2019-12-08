class Product < ApplicationRecord
  has_many :items
#/\A[a-zA-Z]{3}\d{6}\z/
  validates :unique_code, uniqueness: true
  validates :unique_code, format: { with: /\A(?=(?:.*\d){6})(?=(?:.*[a-zA-Z]){3})^[a-zA-Z\d]*$\z/ , message: "must be contain 3 letters and 6 digits"}, length: { is: 9 }
  validates :description, length: { maximum: 200 }
  validates :detail, length: { maximum: 1000 }
  validates :unique_code, :description, :detail, :unit_price, presence: true

  ## ClassMethods to search params
  def self.in_stock(records_limit)
    self.order(:id).limit(records_limit).select{ |p| p.items_available.count > 0 }

  end
  def self.scarce(records_limit, scarce_limit)
    self.order(:id).limit(records_limit).select{ |p| p.items_available.count > 0 and p.items_available.count <= 5}
  end
  def self.all_limit(records_limit)
    self.all.order(:id).limit(records_limit)
  end

  ## Instance methods
  def items_available
    self.items.select{ |i| i.state == 'disponible'}
  end
end
