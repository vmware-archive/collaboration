require 'spec_helper'

describe "projects/edit.html.erb" do
  before(:each) do
    @project = assign(:project, stub_model(Project,
      :display_name => "MyString",
      :org_id => 1,
      :apply_to_all_resources => false,
      :browsable => false,
      :public_roster => false
    ))
  end

  it "renders the edit project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => projects_path(@project), :method => "post" do
      assert_select "input#project_display_name", :name => "project[display_name]"
      assert_select "input#project_org_id", :name => "project[org_id]"
      assert_select "input#project_apply_to_all_resources", :name => "project[apply_to_all_resources]"
      assert_select "input#project_browsable", :name => "project[browsable]"
      assert_select "input#project_public_roster", :name => "project[public_roster]"
    end
  end
end
