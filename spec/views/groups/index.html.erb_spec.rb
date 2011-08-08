require 'spec_helper'

describe "groups/index.html.erb" do
  before(:each) do
    @org =  assign(:org, stub_model(Org,
      :display_name => "An org",
      :id => 1
    ))
    assign(:groups, [
      stub_model(Group,
        :display_name => "A group",
        :org => @org
      ),
      stub_model(Group,
        :display_name => "A group",
        :org => @org
      )
    ])
  end

  it "renders a list of groups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "A group".to_s, :count => 2
  end
end
