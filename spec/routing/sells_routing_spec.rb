require "rails_helper"

RSpec.describe SellsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/sells").to route_to("sells#index")
    end

    it "routes to #show" do
      expect(:get => "/sells/1").to route_to("sells#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/sells").to route_to("sells#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sells/1").to route_to("sells#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sells/1").to route_to("sells#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sells/1").to route_to("sells#destroy", :id => "1")
    end
  end
end
