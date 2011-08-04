require 'spec_helper'

describe "resource_assignments/index.html.erb" do
  before(:each) do
    assign(:resource_assignments, [
      stub_model(ResourceAssignment,
        :permission_set => 1,
        :project_id => 1,
        :entity_id => 1,
        :entity_type => "Entity Type",
        :resource_ownership_id => 1
      ),
      stub_model(ResourceAssignment,
        :permission_set => 1,
        :project_id => 1,
        :entity_id => 1,
        :entity_type => "Entity Type",
        :resource_ownership_id => 1
      )
    ])
  end

  it "renders a list of resource_assignments" do
    render
    ## Run the generator again with the --webrat flag if you want to use webrat matchers
    #assert_select "tr>td", :text => 1.to_s, :count => 2
    ## Run the generator again with the --webrat flag if you want to use webrat matchers
    #assert_select "tr>td", :text => 1.to_s, :count => 2
    ## Run the generator again with the --webrat flag if you want to use webrat matchers
    #assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Entity Type".to_s, :count => 2
    ## Run the generator again with the --webrat flag if you want to use webrat matchers
    #assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
