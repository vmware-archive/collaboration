require 'spec_helper'

describe "acls/show.html.erb" do
  before(:each) do
    @org = assign(:org, stub_model(Org, :display_name => 'VMWare'))
    @project = assign(:project, stub_model(Project, :org => @org, :display_name => 'Cloud Foundry'))
    @app = assign(:app, stub_model(App, :display_name => 'Optimus', :project => @project))
    @owned_resource = assign(:owned_resource, stub_model(OwnedResource, :org => @org, :resource => @app))
    @user = assign(:user, stub_model(User, :first_name => 'Monica', :last_name => 'Wilkinson', :display_name => 'Monica W'))
    @acl = assign(:acl, stub_model(Acl, :owned_resource => @owned_resource, :entity => @user))
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/Optimus/)
  end
end
