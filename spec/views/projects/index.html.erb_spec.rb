require 'spec_helper'

describe "projects/index.html.erb" do
  before(:each) do
    assign(:projects, [
      stub_model(Project,
        :display_name => "Display Name",
        :organization_id => 1,
        :apply_to_all_resources => false,
        :browsable => false,
        :public_roster => false
      ),
      stub_model(Project,
        :display_name => "Display Name",
        :organization_id => 1,
        :apply_to_all_resources => false,
        :browsable => false,
        :public_roster => false
      )
    ])
  end

  it "renders a list of projects" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Display Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    #assert_select "tr>td", :text => 1.to_s, :count => 2
    ## Run the generator again with the --webrat flag if you want to use webrat matchers
    #assert_select "tr>td", :text => false.to_s, :count => 2
    ## Run the generator again with the --webrat flag if you want to use webrat matchers
    #assert_select "tr>td", :text => false.to_s, :count => 2
    ## Run the generator again with the --webrat flag if you want to use webrat matchers
    #assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
