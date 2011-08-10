require "spec_helper"

describe ServicesController do
  before(:each) do
    pwd = 'cloud$'
    @user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
    sign_in @user
  end
  describe "routing" do

    #it "routes to #index" do
    #  get("/services").should route_to("services#index")
    #end
    #
    #it "routes to #new" do
    #  get("/services/new").should route_to("services#new")
    #end
    #
    #it "routes to #show" do
    #  get("/services/1").should route_to("services#show", :id => "1")
    #end
    #
    #it "routes to #edit" do
    #  get("/services/1/edit").should route_to("services#edit", :id => "1")
    #end
    #
    #it "routes to #create" do
    #  post("/services").should route_to("services#create")
    #end
    #
    #it "routes to #update" do
    #  put("/services/1").should route_to("services#update", :id => "1")
    #end
    #
    #it "routes to #destroy" do
    #  delete("/services/1").should route_to("services#destroy", :id => "1")
    #end

  end
end
