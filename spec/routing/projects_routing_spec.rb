require "spec_helper"

describe ProjectsController do
  describe "routing" do

    it "routes to #index" do
      get("/orgs/10/projects").should route_to("projects#index", :org_id => "10")
    end

    it "routes to #new" do
      get("/orgs/10/projects/new").should route_to("projects#new", :org_id => "10")
    end

    it "routes to #show" do
      get("/orgs/10/projects/1").should route_to("projects#show", :org_id => "10", :id => "1")
    end

    it "routes to #edit" do
      get("/orgs/10/projects/1/edit").should route_to("projects#edit", :org_id => "10", :id => "1")
    end

    it "routes to #create" do
      post("/orgs/10/projects").should route_to("projects#create", :org_id => "10")
    end

    it "routes to #update" do
      put("/orgs/10/projects/1").should route_to("projects#update", :org_id => "10", :id => "1")
    end

    it "routes to #destroy" do
      delete("/orgs/10/projects/1").should route_to("projects#destroy", :org_id => "10", :id => "1")
    end

  end
end
