require 'spec_helper'

describe "acls/new.html.erb" do
  before(:each) do
    @org = assign(:org, stub_model(Org, :display_name => 'VMWare'))
    @project = assign(:project, stub_model(Project, :org => @org, :display_name => 'Cloud Foundry'))
    @app = assign(:app, stub_model(App, :display_name => 'Optimus', :project => @project))
    @owned_resource = assign(:owned_resource, stub_model(OwnedResource, :org => @org, :resource => @app))
    @user = assign(:user, stub_model(User, :first_name => 'Monica', :last_name => 'Wilkinson', :display_name => 'Monica W'))
    @acl = assign(:acl, stub_model(Acl, :owned_resource => @owned_resource, :entity => @user).as_new_record)
  end

  it "renders new acl form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => org_project_acls_path(@org, @project, 'entity_type' => 'User'), :method => "post" do
      assert_select "select#acl_entity_id", :name => "acl[entity_id]"
      assert_select "select#acl_owned_resource_id", :name => "acl[owned_resource_id]"
    end
  end
end
