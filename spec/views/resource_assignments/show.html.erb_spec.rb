require 'spec_helper'

describe "resource_assignments/show.html.erb" do
  before(:each) do
    @resource_assignment = assign(:resource_assignment, stub_model(ResourceAssignment,
      :permission_set => 1,
      :project_id => 1,
      :entity_id => 1,
      :entity_type => "Entity Type",
      :resource_ownership_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Entity Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
