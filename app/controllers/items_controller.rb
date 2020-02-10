class ItemsController < ApplicationController
  before_action :set_product
  before_action :authorize_request

  # GET /productos/:producto_id/items
  def index
    @items = Product.find(params[:producto_id]).items
    render json: @items
  end

  # POST /productos/:producto_id/items
  def create
    # Class PostItem is used to validate that the parameters entered are valid
    product=PostItem.new(product_id:params[:producto_id], quantity: item_params[:quantity])
    if product.valid?
      product.create_items
      render json: @product, status: :created
    else
      render json: product.errors, status: :unprocessable_entity
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
end
