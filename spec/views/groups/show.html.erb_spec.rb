require 'spec_helper'

describe "groups/show.html.erb" do
  before(:each) do
     @org =  assign(:org, stub_model(Org,
      :display_name => "An org",
      :id => 1
    ))
    @group = assign(:group, stub_model(Group,
      :display_name => "Group",
      :org => @org
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Group/)
  end
end
