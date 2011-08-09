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
    user.reload.projects.count.should == 1
  end

end