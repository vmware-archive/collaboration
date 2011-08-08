require 'spec_helper'

describe "groups/edit.html.erb" do
  before(:each) do
    @org =  assign(:org, stub_model(Org,
      :display_name => "MyString",
      :id => 1
    ))
    @group = assign(:group, stub_model(Group,
      :display_name => "MyString",
      :org => @org
    ))
  end

  it "renders the edit group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => org_groups_path(@org, @group), :method => "post" do
      assert_select "input#group_display_name", :name => "group[display_name]"
    end
  end
end
