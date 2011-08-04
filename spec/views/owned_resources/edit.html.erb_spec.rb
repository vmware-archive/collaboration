require 'spec_helper'

describe "owned_resources/edit.html.erb" do
  before(:each) do
    @owned_resource = assign(:owned_resource, stub_model(OwnedResource,
      :display_name => "MyString",
      :marked_for_transfer => "",
      :deleted => ""
    ))
  end

  it "renders the edit owned_resource form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => owned_resources_path(@owned_resource), :method => "post" do
      assert_select "input#owned_resource_display_name", :name => "owned_resource[display_name]"
      assert_select "input#owned_resource_marked_for_transfer", :name => "owned_resource[marked_for_transfer]"
      assert_select "input#owned_resource_deleted", :name => "owned_resource[deleted]"
    end
  end
end
