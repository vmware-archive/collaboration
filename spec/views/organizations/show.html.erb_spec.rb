require 'spec_helper'

describe "organizations/show.html.erb" do
  before(:each) do
    @organization = assign(:organization, stub_model(Organization,
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
