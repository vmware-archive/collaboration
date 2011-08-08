require 'spec_helper'

describe "projects/show.html.erb" do
  before(:each) do
    @org =  assign(:org, stub_model(Org,
      :display_name => "MyString",
      :id => 1
    ))
    @project = assign(:project, stub_model(Project,
      :display_name => "Display Name",
      :apply_to_all_resources => false,
      :browsable => false,
      :public_roster => false,
      :org => @org
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Display Name/)
  end
end
