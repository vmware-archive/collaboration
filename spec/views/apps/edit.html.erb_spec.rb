require 'spec_helper'

describe "apps/edit.html.erb" do
  before(:each) do
    pwd = 'cloud$'
    @user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
    sign_in @user

    @app = assign(:app, stub_model(App,
      :display_name => "MyString",
      :framework => "MyString",
      :runtime => "MyString",
      :state => "MyString",
      :creator => @user,
      :project => @user.personal_org.default_project
    ))
  end

  it "renders the edit app form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => apps_path(@app), :method => "post" do
      assert_select "input#app_display_name", :name => "app[display_name]"
      assert_select "input#app_framework", :name => "app[framework]"
      assert_select "input#app_runtime", :name => "app[runtime]"
    end
  end
end
