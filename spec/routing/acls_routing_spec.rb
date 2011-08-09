require "spec_helper"

describe AclsController do
  describe "routing" do

    it "routes to #index" do
      get("/orgs/10/projects/5/acls").should route_to("acls#index", :org_id => "10", :project_id => "5")
    end

    it "routes to #new" do
      get("/orgs/10/projects/5/acls/new").should route_to("acls#new", :org_id => "10", :project_id => "5")
    end

    it "routes to #show" do
      get("/orgs/10/projects/5/acls/1").should route_to("acls#show", :org_id => "10", :project_id => "5", :id => "1")
    end

    it "routes to #edit" do
      get("/orgs/10/projects/5/acls/1/edit").should route_to("acls#edit", :org_id => "10", :project_id => "5", :id => "1")
    end

    it "routes to #create" do
      post("/orgs/10/projects/5/acls").should route_to("acls#create", :org_id => "10", :project_id => "5")
    end

    it "routes to #update" do
      put("/orgs/10/projects/5/acls/1").should route_to("acls#update", :org_id => "10", :project_id => "5", :id => "1")
    end

    it "routes to #destroy" do
      delete("/orgs/10/projects/5/acls/1").should route_to("acls#destroy", :org_id => "10", :project_id => "5", :id => "1")
    end

  end
end
