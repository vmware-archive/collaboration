require 'spec_helper'

describe "owned_resources/show.html.erb" do
  before(:each) do
    @owned_resource = assign(:owned_resource, stub_model(OwnedResource,
      :display_name => "Display Name",
      :marked_for_transfer => "",
      :deleted => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Display Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
