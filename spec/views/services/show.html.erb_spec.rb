require 'spec_helper'

describe "services/show.html.erb" do
  before(:each) do
    @service = assign(:service, stub_model(Service,
      :display_name => "Display Name",
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Display Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
  end
end
