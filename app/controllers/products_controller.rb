class ProductsController < ApplicationController
  before_action :set_product, only: :show
  before_action :authorize_request

  # GET /products
  def index
    records_limit = 25
    scarce_limit = 5

    case filter
    when 'in_stock'
      @products = Product.in_stock(records_limit)
    when 'scarce'
      @products = Product.scarce(records_limit,scarce_limit)
    when 'all'
      @products = Product.all_limit(records_limit)
    else
      @products = Product.in_stock(records_limit)
    end

    render json: @products, status: :ok
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
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

    def filter
      params[:q]
    end
end
