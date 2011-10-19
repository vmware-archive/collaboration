require 'spec_helper'

describe "apps/index.html.erb" do
  before(:each) do
    pwd = 'cloud$'
    @user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
    sign_in @user
    assign(:apps, [
      stub_model(App,
        :display_name => "Display Name",
        :framework => "Framework",
        :runtime => "Runtime",
        :state => "State",
        :creator => @user,
        :project => @user.personal_org.default_project
      ),
      stub_model(App,
        :display_name => "Display Name",
        :framework => "Framework",
        :runtime => "Runtime",
        :state => "State",
        :creator => @user,
        :project => @user.personal_org.default_project
      )
    ])
  end

  it "renders a list of apps" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "ul>li>h3", :text => "Display Name".to_s, :count => 2
  end
end
