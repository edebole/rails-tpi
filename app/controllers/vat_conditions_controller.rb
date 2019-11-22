class VatConditionsController < ApplicationController
  before_action :set_vat_condition, only: [:show, :update, :destroy]

  # GET /vat_conditions
  def index
    @vat_conditions = VatCondition.all

    render json: @vat_conditions
  end

  # GET /vat_conditions/1
  def show
    render json: @vat_condition
  end

  # POST /vat_conditions
  def create
    @vat_condition = VatCondition.new(vat_condition_params)

    if @vat_condition.save
      render json: @vat_condition, status: :created, location: @vat_condition
    else
      render json: @vat_condition.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /vat_conditions/1
  def update
    if @vat_condition.update(vat_condition_params)
      render json: @vat_condition
    else
      render json: @vat_condition.errors, status: :unprocessable_entity
    end
  end

  # DELETE /vat_conditions/1
  def destroy
    @vat_condition.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vat_condition
      @vat_condition = VatCondition.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vat_condition_params
      params.require(:vat_condition).permit(:code, :description)
    end
end
