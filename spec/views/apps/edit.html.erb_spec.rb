require 'spec_helper'

describe "apps/edit.html.erb" do
  before(:each) do
    pwd = 'cloud$'
    @user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
    sign_in @user

    @app = App.create! :display_name => 'Transcoder', :creator => @user, :project => @user.personal_org.default_project, :url =>  "trans.cloudfoundry.com"
    @app = @app.reload
  end

  it "renders the edit app form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => apps_path(@app), :method => "post" do
      assert_select "input#app_display_name", :name => "app[display_name]"
      assert_select "input#app_framework", :name => "app[framework]"
      assert_select "input#app_runtime", :name => "app[runtime]"
      assert_select "input#app_description", :name => "app[description]"
      assert_select "input#app_url", :name => "app[url]"
    end
  end
end
