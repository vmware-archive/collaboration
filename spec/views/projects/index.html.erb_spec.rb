require 'spec_helper'

describe "projects/index.html.erb" do
  before(:each) do
    @org =  assign(:org, stub_model(Org,
      :display_name => "MyString",
      :id => 1
    ))
    assign(:projects, [
      stub_model(Project,
        :display_name => "Display Name",
        :org => @org
      ),
      stub_model(Project,
        :display_name => "Display Name",
        :org => @org
      )
    ])
  end

  it "renders a list of projects" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "ul>li", :text => "Display Name".to_s, :count => 2
  end
end
