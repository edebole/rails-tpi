require 'rails_helper'

RSpec.describe "Reservations", type: :request do
  describe "GET /reservas" do
    it "works! (now write some real specs)" do
      get reservas_path
      expect(response).to have_http_status(200)
    end
  end
end
