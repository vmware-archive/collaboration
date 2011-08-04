require 'spec_helper'

describe "services/index.html.erb" do
  before(:each) do
    assign(:services, [
      stub_model(Service,
        :display_name => "Display Name",
        :url => "Url"
      ),
      stub_model(Service,
        :display_name => "Display Name",
        :url => "Url"
      )
    ])
  end

  it "renders a list of services" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Display Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
