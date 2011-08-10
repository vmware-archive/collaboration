require 'spec_helper'

describe "groups/index.html.erb" do
  before(:each) do
    pwd = 'cloud$'
    @user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
    sign_in @user
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
