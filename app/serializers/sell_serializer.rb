class SellSerializer < ActiveModel::Serializer
  attributes :id, :sell_date
  has_one :client
  has_one :user
  has_one :reservation
end
