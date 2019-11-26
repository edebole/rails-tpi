class JsonWebToken
# our secret key to encode our jwt
  ALGORITHM = 'RS512'
  class << self
    
    def encode(payload, exp = 30.minutes.from_now)
      # set token expiration time 
      payload[:exp] = exp.to_i
      
       # this encodes the user data(payload) with our secret key
      JWT.encode(payload, private_key, ALGORITHM)
    end

    def decode(token)
      #decodes the token to get user data (payload)
      body = JWT.decode(token, private_key.public_key, true, algorithm: ALGORITHM)[0]
      HashWithIndifferentAccess.new body

    # raise custom error to be handled by custom handler
    rescue JWT::ExpiredSignature, JWT::VerificationError => e
      raise ExceptionHandler::ExpiredSignature, e.message
    rescue JWT::DecodeError, JWT::VerificationError => e
      raise ExceptionHandler::DecodeError, e.message
    end

    private

      def private_key
        @rsa_private ||= OpenSSL::PKey::RSA.generate 2048
      end
  end
end
