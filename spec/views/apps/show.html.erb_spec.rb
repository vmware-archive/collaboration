require 'spec_helper'

describe "apps/show.html.erb" do
  before(:each) do
    @app = assign(:app, stub_model(App,
      :display_name => "Display Name",
      :framework => "Framework",
      :runtime => "Runtime",
      :state => "State"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Display Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Framework/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Runtime/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/State/)
  end
end
