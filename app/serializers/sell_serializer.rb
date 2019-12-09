class SellSerializer < ActiveModel::Serializer
  attributes :sell_date, :client_name, :total
  belongs_to :client
  belongs_to :user
  belongs_to :reservation
  has_many :products

  def client_name
    object.client.name
  end
  def total
    object.sell_details.sum(:price)
  end
end
