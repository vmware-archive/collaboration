require "spec_helper"

describe ResourceAssignmentsController do
  describe "routing" do

    it "routes to #index" do
      get("/resource_assignments").should route_to("resource_assignments#index")
    end

    it "routes to #new" do
      get("/resource_assignments/new").should route_to("resource_assignments#new")
    end

    it "routes to #show" do
      get("/resource_assignments/1").should route_to("resource_assignments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/resource_assignments/1/edit").should route_to("resource_assignments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/resource_assignments").should route_to("resource_assignments#create")
    end

    it "routes to #update" do
      put("/resource_assignments/1").should route_to("resource_assignments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/resource_assignments/1").should route_to("resource_assignments#destroy", :id => "1")
    end

  end
end
