class ProductsController < ApplicationController
  before_action :set_product, only: :show
  # before_action :authorize_request

  # GET /products
  def index
    # search is a parameter
    case search
    when 'in_stock'
      @products = Product.in_stock
    when 'scarce'
      @products = Product.scarce
    when 'all'
      @products = Product.all_limit
    else
      @products = Product.in_stock
    end
    render json: @products, status: :ok
  end

  # GET /products/1
  def show
    render json: @product
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:unique_code, :description, :detail, :unit_price, :items_id)
    end

    def search
      params[:q]
    end
end
