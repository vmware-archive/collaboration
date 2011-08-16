require 'spec_helper'

describe Service do
  before(:each) do
    pwd = 'cloud$'
    @user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'dale@vmware.com'
    @org = Org.first
  end

  it "can create an instance of Service" do
    s = Service.new
    s.should be_instance_of(Service)
  end

  it "requires a creator" do
    s = Service.new :display_name => 'Optimus', :project => @org.default_project
    s.valid?.should be_false

    s.creator = @user
    s.valid?.should be_true
  end

  it "creates an owned resource for the org after saving" do
    s = Service.create! :display_name => 'Optimus', :project => @org.default_project, :creator => @user
    owned_res = s.reload.main_owned_resource
    owned_res.should_not be_nil
    owned_res.owner.should eq(@org)
  end

  it "deletes the owned resource if the service is deleted" do
    s = Service.create! :display_name => 'Optimus', :project => @org.default_project, :creator => @user
    owned_res = s.reload.main_owned_resource

    s.destroy
    lambda {
      owned_res.reload
      }.should raise_exception
  end
end
