require 'spec_helper'

describe "resource_assignments/new.html.erb" do
  before(:each) do
    assign(:resource_assignment, stub_model(ResourceAssignment,
      :permission_set => 1,
      :project_id => 1,
      :entity_id => 1,
      :entity_type => "MyString",
      :resource_ownership_id => 1
    ).as_new_record)
  end

  it "renders new resource_assignment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => resource_assignments_path, :method => "post" do
      assert_select "input#resource_assignment_permission_set", :name => "resource_assignment[permission_set]"
      assert_select "input#resource_assignment_project_id", :name => "resource_assignment[project_id]"
      assert_select "input#resource_assignment_entity_id", :name => "resource_assignment[entity_id]"
      assert_select "input#resource_assignment_entity_type", :name => "resource_assignment[entity_type]"
      assert_select "input#resource_assignment_resource_ownership_id", :name => "resource_assignment[resource_ownership_id]"
    end
  end
end
