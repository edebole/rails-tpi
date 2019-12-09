require 'rails_helper'

RSpec.describe "Reservations", type: :request do
  describe "GET /reservas" do
    it "when logged in" do
      user = FactoryBot.create(:user)
      token = JsonWebToken.encode(user_id: user.id)
      get reservas_path, headers: { "Authorization" => token }
      expect(response).to have_http_status(200)
    end
    it "when logged out" do
      get reservas_path
      expect(response).to have_http_status(401)
    end
  end
end
