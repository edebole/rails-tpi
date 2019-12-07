class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :update, :destroy, :sell]
  before_action :authorize_request

  # GET /reservas
  def index
    @reservations = Reservation.not_sell

    render json: @reservations, status: :ok
  end

  # GET /reservas/:id
  def show
    case params[:include]
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
    reservation = PostReservation.new(reservation_params)
    if reservation.valid?
      Reservation.transaction do
        reservation = reservation.create_reservation(@current_user.id)
        reservation.reserve_items(reservation_params[:products])
        render json: reservation, status: :created
      end
    else
      render json: reservation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reservas/1
  def destroy
    unless @reservation.sell?
      @reservation.items.map do |item|
        item.cancel!
      end
      @reservation.destroy
      render json: @reservation, status: :ok
    else
      raise ActiveRecord::RecordInvalid 
    end
  end

  # PUT /reservas/1
  def sell
    unless @reservation.sell?
      @reservation.transaction do
        current_sell = @reservation.create_sell

        @reservation.sell_items(current_sell.id)
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
      params.require(:reservation).permit(:client_id, products: [:product_id, :quantity])
    end

end
