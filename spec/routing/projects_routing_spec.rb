require "spec_helper"

describe ProjectsController do
  describe "routing" do

    it "routes to #index" do
      get("/orgs/10/projects").should route_to("projects#index", :id => "10")
    end

    it "routes to #new" do
      get("/orgs/10/projects/new").should route_to("projects#new", :id => "10")
    end

    it "routes to #show" do
      get("/orgs/10/projects/1").should route_to("projects#show", :id => "1")
    end

    it "routes to #edit" do
      get("/orgs/10/projects/1/edit").should route_to("projects#edit", :id => "1")
    end

    it "routes to #create" do
      post("/orgs/10/projects").should route_to("projects#create", :id => "10")
    end

    it "routes to #update" do
      put("/orgs/10/projects/1").should route_to("projects#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/orgs/10/projects/1").should route_to("projects#destroy", :id => "1")
    end

  end
end
