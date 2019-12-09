require 'rails_helper'

RSpec.describe "Sells", type: :request do
  describe "GET /ventas" do
       it "when logged in" do
      user = FactoryBot.create(:user)
      token = JsonWebToken.encode(user_id: user.id)
      get ventas_path, headers: { "Authorization" => token }
      expect(response).to have_http_status(200)
    end
    it "when logged out" do
      get ventas_path
      expect(response).to have_http_status(401)
    end
  end
end
