class PostSell < PostReservation
  def create_sell(id_user)
    Sell.create!(client_id: client_id, user_id: id_user)
  end

  def create_reservation(user_id)
    # def blank for parent class 
  end
end
