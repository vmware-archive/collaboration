require "spec_helper"

describe OrganizationsController do
  describe "routing" do

    it "routes to #index" do
      get("/orgs").should route_to("organizations#index")
    end

    it "routes to #new" do
      get("/orgs/new").should route_to("organizations#new")
    end

    it "routes to #show" do
      get("/orgs/1").should route_to("organizations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/orgs/1/edit").should route_to("organizations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/orgs").should route_to("organizations#create")
    end

    it "routes to #update" do
      put("/orgs/1").should route_to("organizations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/orgs/1").should route_to("organizations#destroy", :id => "1")
    end

  end
end
