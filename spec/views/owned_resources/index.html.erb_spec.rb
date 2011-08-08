require 'spec_helper'

describe "owned_resources/index.html.erb" do
  before(:each) do
    @org =  assign(:org, stub_model(Org,
      :display_name => "MyString",
      :id => 1
    ))
    assign(:owned_resources, [
      stub_model(OwnedResource,
        :display_name => "Display Name",
        :marked_for_transfer => "",
        :deleted => "",
        :org => @org
      ),
      stub_model(OwnedResource,
        :display_name => "Display Name",
        :marked_for_transfer => "",
        :deleted => "",
        :org => @org
      )
    ])
  end

  it "renders a list of owned_resources" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Display Name".to_s, :count => 2
  end
end
