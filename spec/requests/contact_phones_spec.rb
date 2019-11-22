require 'rails_helper'

RSpec.describe "ContactPhones", type: :request do
  describe "GET /contact_phones" do
    it "works! (now write some real specs)" do
      get contact_phones_path
      expect(response).to have_http_status(200)
    end
  end
end
