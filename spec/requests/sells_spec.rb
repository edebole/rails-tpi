require 'rails_helper'

RSpec.describe "Sells", type: :request do
  describe "GET /ventas" do
    it "works! (now write some real specs)" do
      get ventas_path
      expect(response).to have_http_status(200)
    end
  end
end
