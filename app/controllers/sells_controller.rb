class SellsController < ApplicationController
  before_action :set_sell, only: [:show, :update, :destroy]
  before_action :authorize_request

  # GET /ventas
  def index
    @sells = Sell.all_for_user(@current_user.id)
    render json: @sells, status: :ok
  end

  # GET /ventas/1
  def show
    if @sell.user_is_owner?(@current_user.id)
      # compound is a parameter
      case compound
      when 'items'
        render json: @sell, include: :items, status: :ok
      else
        render json: @sell, status: :ok
      end
    else
      raise ExceptionHandler::NotOwner
    end
  end

  # POST /ventas
  def create
    # Class PostSell is used to validate that the parameters entered are valid
    sell = PostSell.new(sell_params)
    if sell.valid?
      Sell.transaction do
        sell = sell.create_sell(@current_user.id)
        sell.sell_items(sell_params[:products])
        render json: sell, status: :created
      end
    else
      render json: sell.errors, status: :unprocessable_entity
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sell
      @sell = Sell.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sell_params
      params.require(:sell).permit(:client_id, products: [:product_id, :quantity])
    end

    def compound
      params[:include]
    end

end
