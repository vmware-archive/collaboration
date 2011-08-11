require 'spec_helper'

describe User do
  it "can be instantiated" do
    new_user = User.new :first_name => 'Monica', :last_name => 'Wilkinson'
    new_user.should be_an_instance_of(User)
  end

  it "requires email and password" do
    pwd = 'cloud$'
    user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
    user.reload.id.should_not be_nil
  end

  it "creates a personal org for the user" do
    pwd = 'cloud$'
    user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
    user.reload.id.should_not be_nil
    Org.all.count.should == 1
    user.personal_org.should_not be_nil
  end

  it "properly selects the orgs it has access to" do
    pwd = 'cloud$'
    user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
    user.orgs_with_access.should eq([user.personal_org])

    org2 = Org.create! :display_name => "NASA", :creator => user
    user.reload.orgs_with_access.should eq([user.personal_org, org2])
  end

end