require 'spec_helper'

describe "owned_resources/index.html.erb" do
  before(:each) do
    @app = assign(:org, stub_model(App,
      :display_name => "Bot"
    ))
    @app2 = assign(:org, stub_model(App,
      :display_name => "Bot"
    ))
    @org =  assign(:org, stub_model(Org,
      :display_name => "Hasbro"
    ))
    assign(:owned_resources, [
      stub_model(OwnedResource,
        :org => @org,
        :resource => @app
      ),
      stub_model(OwnedResource,
        :org => @org,
        :resource => @app2
      )
    ])
  end

  it "renders a list of owned_resources" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Bot".to_s, :count => 2
  end
end
