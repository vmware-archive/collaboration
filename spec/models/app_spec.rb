require 'spec_helper'

describe App do

  before(:each) do
    pwd = 'cloud$'
    @user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'dale@vmware.com'
    @org = Org.first
  end

  it "can create an instance of App" do
    app = App.new
    app.should be_instance_of(App)
  end

  it "requires a url" do
    app = App.new :display_name => 'Optimus', :project => @org.default_project, :creator => @user
    app.valid?.should be_false

    app.url = "optimus.cloudfoundry.com"
    app.valid?.should be_true
  end

  it "requires a creator" do
    app = App.new :display_name => 'Optimus', :project => @org.default_project, :url => "optimus.cloudfoundry.com"
    app.valid?.should be_false

    app.creator = @user
    app.valid?.should be_true
  end

  it "creates an owned resource for the org after saving" do
    app = App.create! :display_name => 'Optimus', :project => @org.default_project, :creator => @user, :url => "optimus.cloudfoundry.com"
    owned_res = app.reload.main_owned_resource
    owned_res.should_not be_nil
    owned_res.owner.should eq(@org)
  end

  it "deletes the owned resource if the app is deleted" do
    app = App.create! :display_name => 'Optimus', :project => @org.default_project, :creator => @user, :url => "optimus.cloudfoundry.com"
    owned_res = app.reload.main_owned_resource

    app.destroy
    lambda {
      owned_res.reload
      }.should raise_exception
  end
end
