class ContactPhonesController < ApplicationController
  before_action :set_contact_phone, only: [:show, :update, :destroy]

  # GET /contact_phones
  def index
    @contact_phones = ContactPhone.all

    render json: @contact_phones
  end

  # GET /contact_phones/1
  def show
    render json: @contact_phone
  end

  # POST /contact_phones
  def create
    @contact_phone = ContactPhone.new(contact_phone_params)

    if @contact_phone.save
      render json: @contact_phone, status: :created, location: @contact_phone
    else
      render json: @contact_phone.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contact_phones/1
  def update
    if @contact_phone.update(contact_phone_params)
      render json: @contact_phone
    else
      render json: @contact_phone.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contact_phones/1
  def destroy
    @contact_phone.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact_phone
      @contact_phone = ContactPhone.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contact_phone_params
      params.require(:contact_phone).permit(:phone, :client_id)
    end
end
