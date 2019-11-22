require 'rails_helper'

RSpec.describe "VatConditions", type: :request do
  describe "GET /vat_conditions" do
    it "works! (now write some real specs)" do
      get vat_conditions_path
      expect(response).to have_http_status(200)
    end
  end
end
