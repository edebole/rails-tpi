class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :update, :destroy]
  #before_action :authorize_request

  # GET /reservas
  def index
    @reservations = Reservation.not_sell

    render json: @reservations, status: :ok
  end

  # GET /reservas/:id
  def show
    case compound
    when 'items'
      render json: @reservation, include: :items, status: :ok
    when 'sell'
      render json: @reservation, include: :sell, status: :ok
    else
      render json: @reservation, status: :ok
    end
  end

  # POST /reservas
  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      render json: @reservation, status: :created, location: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reservas/1
  def update
    if @reservation.update(reservation_params)
      render json: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reservas/1
  def destroy
    @reservation.destroy
  end

  def sell
    is_sell = Sell.where({reservation_id: self.id})
    if is_sell.none?
      teko.transaction do
        Sell.create!(
          client_id: teko.client_id,
          user_id: teko.user_id,
          reservation_id: teko.id,
          sell_date: Time.now,
        )
        current_sell = Sell.last
        teko.items.each do |item|
          item.sell!
          SellDetail.create!(
            item_id: item.id, 
            sell_id: current_sell.id, 
            price: teko.reservation_details.find_by_item_id(item.id).price)
        end
      end
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def reservation_params
      params.require(:reservation).permit(:references, :references, :reservation_date)
    end
    def compound
      params[:include]
    end
end
