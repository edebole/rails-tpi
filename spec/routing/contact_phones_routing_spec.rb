require "rails_helper"

RSpec.describe ContactPhonesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/contact_phones").to route_to("contact_phones#index")
    end

    it "routes to #show" do
      expect(:get => "/contact_phones/1").to route_to("contact_phones#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/contact_phones").to route_to("contact_phones#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/contact_phones/1").to route_to("contact_phones#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/contact_phones/1").to route_to("contact_phones#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/contact_phones/1").to route_to("contact_phones#destroy", :id => "1")
    end
  end
end
