require 'spec_helper'

describe "groups/new.html.erb" do
  before(:each) do
     @org =  assign(:org, stub_model(Org,
      :display_name => "An org",
      :id => 1
    ))
    assign(:group, stub_model(Group,
      :display_name => "MyString",
      :org => @org
    ).as_new_record)
  end

  it "renders new group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => org_groups_path(@org), :method => "post" do
      assert_select "input#group_display_name", :name => "group[display_name]"
    end
  end
end
