require "rails_helper"

RSpec.describe ReservationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/reservas").to route_to("reservations#index")
    end

    it "routes to #show" do
      expect(:get => "/reservas/1").to route_to("reservations#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/reservas").to route_to("reservations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/reservas/1/vender").to route_to("reservations#sell", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/reservas/1").to route_to("reservations#destroy", :id => "1")
    end
  end
end
