class Product < ApplicationRecord
  has_many :items
  def self.in_stock(records_limit)
    self.joins(:items).group(:id).having("COUNT(product_id) >= 1").order(:id).limit(records_limit)
  end
  def self.scarce(records_limit, scarce_limit)
    self.joins(:items).group(:id).having("COUNT(product_id) <= #{scarce_limit}").order(:id).limit(records_limit)
  end
  def self.all_limit(records_limit)
    self.all.order(:id).limit(records_limit)
  end
end
