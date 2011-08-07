require "spec_helper"

describe OwnedResourcesController do
  describe "routing" do

    it "routes to #index" do
      get("/orgs/10//owned_resources").should route_to("owned_resources#index", :id => "10")
    end

    it "routes to #new" do
      get("/orgs/10//owned_resources/new").should route_to("owned_resources#new", :id => "10")
    end

    it "routes to #show" do
      get("/orgs/10//owned_resources/1").should route_to("owned_resources#show", :id => "1")
    end

    it "routes to #edit" do
      get("/orgs/10//owned_resources/1/edit").should route_to("owned_resources#edit", :id => "1")
    end

    it "routes to #create" do
      post("/orgs/10//owned_resources").should route_to("owned_resources#create", :id => "10")
    end

    it "routes to #update" do
      put("/orgs/10//owned_resources/1").should route_to("owned_resources#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/orgs/10//owned_resources/1").should route_to("owned_resources#destroy", :id => "1")
    end

  end
end
