class PostReservation
  include ActiveModel::Model 
  include ActiveModel::Validations 
  attr_accessor :client_id, :user_id
  #validates :client_id, :user_id, numericality: { only_integer: true, greater_than: 0 }
  #validates_presence_of :client_id, :user_id
  validate :validate_exist_client


  def create_reservations
    Reservation.create!(client_id: client_id, user_id: user_id, reservation_date: Time.now)
  end

  private
    def validate_exist_client
      unless Client.exists?(client_id)
        errors.add(:client_id, "Client id #{client_id} not exist")
      end
    end
end
