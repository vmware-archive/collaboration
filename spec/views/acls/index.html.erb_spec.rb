require 'spec_helper'

describe "acls/index.html.erb" do
  before(:each) do
    @org = assign(:org, stub_model(Org, :display_name => 'VMWare'))
    @project = stub_model(Project, :org => @org, :display_name => 'Cloud Foundry')
    @user = stub_model(User, :first_name => 'Monica', :last_name => 'Wilkinson', :display_name => 'Monica W')
    @user2 = stub_model(User, :first_name => 'Peter', :last_name => 'Jenkins', :display_name => 'Jenkins')
    @acl = stub_model(Acl, :route => "/groups/*", :entity => @user, :permission_set => PermissionManager::ALL, :project => @project)
    @acl2 = stub_model(Acl, :route => "/apps/*", :entity => @user, :permission_set => PermissionManager::ALL, :project => @project)
    @acl3 = stub_model(Acl, :route => "/apps/*", :entity => @user2, :permission_set => PermissionManager::ALL, :project => @project)
    assign(:acls, [@acl, @acl2, @acl3])
  end

  it "renders a list of acls" do
    render
    assert_select "tr>td", :text => @user.display_name, :count => 2
    assert_select "tr>td", :text => "User", :count => 3
    assert_select "tr>td", :text => "/apps/*", :count => 2
  end
end
