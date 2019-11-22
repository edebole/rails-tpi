require "rails_helper"

RSpec.describe VatConditionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/vat_conditions").to route_to("vat_conditions#index")
    end

    it "routes to #show" do
      expect(:get => "/vat_conditions/1").to route_to("vat_conditions#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/vat_conditions").to route_to("vat_conditions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/vat_conditions/1").to route_to("vat_conditions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/vat_conditions/1").to route_to("vat_conditions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/vat_conditions/1").to route_to("vat_conditions#destroy", :id => "1")
    end
  end
end
