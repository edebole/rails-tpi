require "rails_helper"

RSpec.describe SellsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/ventas").to route_to("sells#index")
    end

    it "routes to #show" do
      expect(:get => "/ventas/1").to route_to("sells#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/ventas").to route_to("sells#create")
    end

  end
end
