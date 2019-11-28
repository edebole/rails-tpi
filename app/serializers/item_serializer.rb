class ItemSerializer < ActiveModel::Serializer
  attributes :id, :state, :price

  def price
    object.product.unit_price
  end
end
