require "rails_helper"

RSpec.describe ItemsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/productos/1/items").to route_to("items#index", :producto_id => "1")
    end

    it "routes to #create" do
      expect(:post => "/productos/1/items").to route_to("items#create", :producto_id => "1")
    end
    
  end
end
