require 'spec_helper'

describe "orgs/show.html.erb" do
  before(:each) do
    @org = assign(:org, stub_model(Org,
      :display_name => "Display Name",
      :avatar => "Avatar",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Display Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Avatar/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
  end
end
