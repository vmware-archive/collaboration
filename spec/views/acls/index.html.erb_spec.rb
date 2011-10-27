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
    assign(:entities, {@acl.entity_display_name => [@acl, @acl2], @acl3.entity_display_name => [@acl3]})
  end

  it "renders a list of acls" do
    render
    assert_select "h4", :text => "#{@acl.entity_display_name} has", :count => 1
    assert_select "li>a", :text => ""
  end
end
