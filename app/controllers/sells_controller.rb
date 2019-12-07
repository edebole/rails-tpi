class SellsController < ApplicationController
  before_action :set_sell, only: [:show, :update, :destroy]
  before_action :authorize_request

  # GET /sells
  def index
    @sells = Sell.all_for_user(@current_user.id)
    render json: @sells, status: :ok
  end

  # GET /sells/1
  def show
    if @sell.user_id == @current_user.id
      case compound
      when 'items'
        render json: @sell, include: :items, status: :ok
      else
        render json: @sell, status: :ok
      end
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  # POST /sells
  def create
    @sell = Sell.new(sell_params)

    if @sell.save
      render json: @sell, status: :created, location: @sell
    else
      render json: @sell.errors, status: :unprocessable_entity
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sell
      @sell = Sell.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sell_params
      params.require(:sell).permit(:client_id, :user_id, :reservation_id, :sell_date)
    end
    def compound
      params[:include]
    end

end