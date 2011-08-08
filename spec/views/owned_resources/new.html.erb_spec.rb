require 'spec_helper'

describe "owned_resources/new.html.erb" do
  before(:each) do
    @org =  assign(:org, stub_model(Org,
      :display_name => "MyString",
      :id => 1
    ))
    assign(:owned_resource, stub_model(OwnedResource,
      :display_name => "MyString",
      :marked_for_transfer => "",
      :deleted => "",
      :org => @org
    ).as_new_record)
  end

  it "renders new owned_resource form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => org_owned_resources_path(@org), :method => "post" do
      assert_select "select#owned_resource_resource_id", :name => "owned_resource[resource_id]"
      assert_select "input#owned_resource_marked_for_transfer", :name => "owned_resource[marked_for_transfer]"
      assert_select "input#owned_resource_deleted", :name => "owned_resource[deleted]"
    end
  end
end
