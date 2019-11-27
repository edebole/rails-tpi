require 'rails_helper'

RSpec.describe "Sells", type: :request do
  describe "GET /sells" do
    it "works! (now write some real specs)" do
      get sells_path
      expect(response).to have_http_status(200)
    end
  end
end
