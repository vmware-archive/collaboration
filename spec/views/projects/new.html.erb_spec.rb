require 'spec_helper'

describe "projects/new.html.erb" do
  before(:each) do
    @org =  assign(:org, stub_model(Org,
      :display_name => "MyString",
      :id => 1
    ))
    assign(:project, stub_model(Project,
      :display_name => "MyString",
      :org => @org
    ).as_new_record)
  end

  it "renders new project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => org_projects_path(@org), :method => "post" do
      assert_select "input#project_display_name", :name => "project[display_name]"
    end
  end
end
