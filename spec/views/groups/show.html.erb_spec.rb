require 'spec_helper'

describe "groups/show.html.erb" do
  before(:each) do
    pwd = 'cloud$'
    @user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
    sign_in @user
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
    #rendered.should match(/Group/)
  end
end
