class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :update, :destroy, :sell]
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

  # DELETE /reservas/1
  def destroy
    unless @reservation.sell?
      @reservation.items.map do |item|
        item.cancel!
      end
      @reservation.destroy
      render json: @reservation, status: :no_content
    else
      raise ActiveRecord::RecordInvalid
    end
  end

  def sell
    unless @reservation.sell?
      @reservation.transaction do
        current_sell = create_sell(@reservation)
        sell_items(current_sell, @reservation)
      end
      render json: @reservation, status: :created
    else
      raise ActiveRecord::RecordInvalid
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
    def create_sell(reservation)
      sell = Sell.create!(
        client_id: reservation.client_id,
        user_id: reservation.user_id,
        reservation_id: reservation.id,
        sell_date: Time.now,
      )
      sell.id
    end
    def sell_items(sell_id,reservation)
      reservation.items.map do |item|
          item.sell!
          SellDetail.create!(
            item_id: item.id, 
            sell_id: sell_id, 
            price: reservation.reservation_details.find_by_item_id(item.id).price
          )
      end
    end
end
