class ItemsController < ApplicationController

  # GET /productos/:producto_id/items
  def index
    # @items = Item.all
    @product = Product.find(params[:producto_id])
    render json: @product.items
  end

  # POST /productos/:producto_id/items
  def create
    @item = Item.new(item_params)

    if @item.save
      render json: @item, status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:state)
    end
end
