require 'spec_helper'

describe "groups/new.html.erb" do
  before(:each) do
    assign(:group, stub_model(Group,
      :display_name => "MyString",
      :organization_id => 1
    ).as_new_record)
  end

  it "renders new group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => groups_path, :method => "post" do
      assert_select "input#group_display_name", :name => "group[display_name]"
      assert_select "input#group_organization_id", :name => "group[organization_id]"
    end
  end
end
