class ProductSerializer < ActiveModel::Serializer
  attributes :id, :unique_code, :description, :detail, :unit_price
  has_one :items
end
