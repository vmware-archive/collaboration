require 'spec_helper'

describe "orgs/index.html.erb" do
  before(:each) do
    assign(:orgs, [
      stub_model(Org,
        :display_name => "Display Name",
        :avatar => "Avatar",
        :description => "Description"
      ),
      stub_model(Org,
        :display_name => "Display Name",
        :avatar => "Avatar",
        :description => "Description"
      )
    ])
  end

  it "renders a list of orgs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "ul>li", :text => "Display Name".to_s, :count => 2
  end
end
