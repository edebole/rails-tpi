class ItemsController < ApplicationController
  before_action :set_product

  # GET /productos/:producto_id/items
  def index
    @product = Product.find(params[:producto_id])
    render json: @product.items
  end

  # POST /productos/:producto_id/items
  def create
    if quantity > 0
      quantity.times{
        @product.items.create!()
      }
      render json: @product, status: :created
    else
      render json: {error: {title: "quantity cannot be less than 1"}}, status: :unprocessable_entity
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:quantity, :producto_id)
    end
    def set_product
      @product = Product.find(params[:producto_id])
    end

    def quantity
      params[:quantity]
    end
end
