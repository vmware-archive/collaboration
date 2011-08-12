require 'spec_helper'

describe "apps/show.html.erb" do
  before(:each) do
    pwd = 'cloud$'
    @user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
    sign_in @user
    @app = assign(:app, stub_model(App,
      :display_name => "Display Name",
      :framework => "Framework",
      :runtime => "Runtime",
      :state => "State",
      :creator => @user,
      :project => @user.personal_org.default_project
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Framework/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Runtime/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/State/)
  end
end
