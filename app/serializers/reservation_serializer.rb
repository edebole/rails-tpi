class ReservationSerializer < ActiveModel::Serializer
  attributes :client_name, :reservation_date, :total
  belongs_to :client
  belongs_to :user
  belongs_to :sell
  has_many :items

  def client_name
    object.client.name
  end
  def total
    object.reservation_details.sum(:price)
  end
end
