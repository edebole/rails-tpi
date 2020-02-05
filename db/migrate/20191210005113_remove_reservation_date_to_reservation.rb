class RemoveReservationDateToReservation < ActiveRecord::Migration[6.0]
  def change
    remove_columns :reservations, :reservation_date 
  end
end
