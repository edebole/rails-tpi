class ReservationSerializer < ActiveModel::Serializer
  attributes :client_name, :created_at, :total
  belongs_to :client
  belongs_to :user
  belongs_to :sell
  has_many :products

  def client_name
    object.client.name
  end
  def total
    object.reservation_details.sum(:price)
  end
end
