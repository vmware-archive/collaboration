require 'spec_helper'

describe "projects/edit.html.erb" do
  before(:each) do
    @org =  assign(:org, stub_model(Org,
      :display_name => "MyString",
      :id => 1
    ))
    @project = assign(:project, stub_model(Project,
      :display_name => "MyString",
      :org_id => 1,
      :apply_to_all_resources => false,
      :browsable => false,
      :public_roster => false,
      :org => @org
    ))
  end

  it "renders the edit project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => org_projects_path(@org, @project), :method => "post" do
      assert_select "input#project_display_name", :name => "project[display_name]"
    end
  end
end
