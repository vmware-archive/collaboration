require 'spec_helper'

describe "owned_resources/show.html.erb" do
  before(:each) do
    @org =  assign(:org, stub_model(Org,
      :display_name => "MyString",
      :id => 1
    ))
    @owned_resource = assign(:owned_resource, stub_model(OwnedResource,
      :display_name => "Display Name",
      :org => @org,
      :marked_for_transfer => "",
      :deleted => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Marked for transfer/)
  end
end
