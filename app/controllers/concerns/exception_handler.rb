module ExceptionHandler
  extend ActiveSupport::Concern
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end
  class DecodeError < StandardError; end
  class ReservationSold < StandardError; end
  class NotOwner < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::ExpiredSignature, with: :four_ninety_eight
    rescue_from ExceptionHandler::DecodeError, with: :four_zero_one
    rescue_from ExceptionHandler::ReservationSold, with: :is_already_sold
    rescue_from ExceptionHandler::NotOwner, with: :not_owner

    rescue_from ActiveRecord::RecordNotFound do |e|
     render json: { errors: {message: e.message }}, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { errors: { message: e.message }}, status: :unprocessable_entity
    end
  end

  private

    # JSON response with message; Status code 422 - unprocessable entity
    def four_twenty_two(e)
     render json: { errors: {message: e.message }}, status: :unprocessable_entity
    end
  
#   JSON response with message; Status code 401 - Unauthorized
    def four_ninety_eight(e)
      render json: { errors: {token: e.message }}, status: :unauthorized
    end

    # JSON response with message; Status code 401 - Unauthorized
    def four_zero_one(e)
      render json: { errors: { token: e.message }}, status: :unauthorized
    end

     # JSON response with message; Status code 401 - Unauthorized
    def unauthorized_request(e)
      render json: { errors: { token: e.message }}, status: :unauthorized
    end

    # JSON response with message; Status code 422 - unprocessable entity
    def is_already_sold
      render json: {"errors": {"reservation": "reservation has already been sold"}}, status:  :unprocessable_entity
    end

    # JSON response with message; Status code 404 - not found
    def not_owner
      render json: {"errors": {"sell": "you are not the sales owner"}}, status: :not_found
    end
end
