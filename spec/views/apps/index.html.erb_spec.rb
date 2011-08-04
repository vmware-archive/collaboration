require 'spec_helper'

describe "apps/index.html.erb" do
  before(:each) do
    assign(:apps, [
      stub_model(App,
        :display_name => "Display Name",
        :framework => "Framework",
        :runtime => "Runtime",
        :state => "State"
      ),
      stub_model(App,
        :display_name => "Display Name",
        :framework => "Framework",
        :runtime => "Runtime",
        :state => "State"
      )
    ])
  end

  it "renders a list of apps" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Display Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Framework".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Runtime".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "State".to_s, :count => 2
  end
end
