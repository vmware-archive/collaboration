require 'spec_helper'

describe "groups/edit.html.erb" do
  before(:each) do
    @group = assign(:group, stub_model(Group,
      :display_name => "MyString",
      :organization_id => 1
    ))
  end

  it "renders the edit group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => groups_path(@group), :method => "post" do
      assert_select "input#group_display_name", :name => "group[display_name]"
      assert_select "input#group_organization_id", :name => "group[organization_id]"
    end
  end
end
