require "spec_helper"

describe GroupsController do
  before(:each) do
    pwd = 'cloud$'
    @user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
    sign_in @user
  end
  describe "routing" do

    #it "routes to #index" do
    #  get("/orgs/10/groups").should route_to("groups#index", :org_id => "10")
    #end
    #
    #it "routes to #new" do
    #  get("/orgs/10/groups/new").should route_to("groups#new", :org_id => "10")
    #end
    #
    #it "routes to #show" do
    #  get("/orgs/10/groups/1").should route_to("groups#show", :org_id => "10", :id => "1")
    #end
    #
    #it "routes to #edit" do
    #  get("/orgs/10/groups/1/edit").should route_to("groups#edit", :org_id => "10", :id => "1")
    #end
    #
    #it "routes to #create" do
    #  post("/orgs/10/groups").should route_to("groups#create", :org_id => "10")
    #end
    #
    #it "routes to #update" do
    #  put("/orgs/10/groups/1").should route_to("groups#update", :org_id => "10", :id => "1")
    #end
    #
    #it "routes to #destroy" do
    #  delete("/orgs/10/groups/1").should route_to("groups#destroy", :org_id => "10", :id => "1")
    #end

  end
end
