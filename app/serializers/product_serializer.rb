class ProductSerializer < ActiveModel::Serializer
  attributes :id, :unique_code, :description, :detail, :unit_price
  has_many :items
end
