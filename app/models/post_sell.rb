class PostSell < PostReservation
  def create_sell(user)
    Sell.create!(client_id: client_id, user_id: user, sell_date: Time.now)
  end
end
