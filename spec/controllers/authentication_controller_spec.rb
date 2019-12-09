require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do

  before(:each) do
    @user = FactoryBot.create(:user)
  end

  let(:valid_attributes) {
    { :username => @user.username, :password => "password" }
  }

  let(:invalid_attributes) {
    { :username => @user.username, :password => "invalid" }
  }
  let(:valid_session) { { } }

  describe "POST #login" do
    context "with valid params" do

      it "renders a JSON response with the new session" do

        post :login, params: {login: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new session" do

        post :login, params: {login: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
