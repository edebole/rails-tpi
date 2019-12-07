require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /productos" do
    it "works! (now write some real specs)" do
      get productos_path
      expect(response).to have_http_status(200)
    end
  end
end
