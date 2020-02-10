class ApplicationController < ActionController::API
  include ExceptionHandler
  
  # authorize_request function has responsibility for authorizing user request. first we need to get token in header with ‘Authorization’ as key
  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    end
  end
end
