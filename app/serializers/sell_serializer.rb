class SellSerializer < ActiveModel::Serializer
  attributes :sell_date, :client_name, :total
  
  def client_name
    object.client.name
  end
  def total
    object.sell_details.sum(:price)
  end
end
