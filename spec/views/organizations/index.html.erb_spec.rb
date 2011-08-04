require 'spec_helper'

describe "organizations/index.html.erb" do
  before(:each) do
    assign(:organizations, [
      stub_model(Organization,
        :display_name => "Display Name",
        :avatar => "Avatar",
        :description => "Description"
      ),
      stub_model(Organization,
        :display_name => "Display Name",
        :avatar => "Avatar",
        :description => "Description"
      )
    ])
  end

  it "renders a list of organizations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Display Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Avatar".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
