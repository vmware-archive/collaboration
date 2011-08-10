require 'spec_helper'

describe "services/index.html.erb" do
  before(:each) do
    pwd = 'cloud$'
    @user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
    sign_in @user
    assign(:services, [
      stub_model(Service,
        :display_name => "Display Name",
        :url => "Url",
        :creator => @user,
        :project => @user.personal_org.default_project
      ),
      stub_model(Service,
        :display_name => "Display Name",
        :url => "Url",
        :creator => @user,
        :project => @user.personal_org.default_project
      )
    ])
  end

  it "renders a list of services" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Display Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
