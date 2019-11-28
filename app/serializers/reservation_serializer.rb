class ReservationSerializer < ActiveModel::Serializer
  attributes :client_name, :reservation_date, :total

  def client_name
    object.client.name
  end
  def total
    object.reservation_details.sum(:price)
  end
end
