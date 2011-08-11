require 'spec_helper'

describe Group do
  before(:each) do
    pwd = 'cloud$'
    @user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'dale@vmware.com'
    @org = Org.create! :display_name => 'NASA', :creator => @user
  end

  it "can be instantiated" do
    new_group = @org.groups.build :display_name => 'Owners'
    new_group.should be_an_instance_of(Group)
  end

  it "can be saved" do
    new_group = @org.groups.build :display_name => 'Owners'
    new_group.save

    new_group.reload.id.should_not be_nil
  end

  it "must have a display name to be valid" do
    new_group = @org.groups.build
    new_group.valid?.should_not be_true

    new_group = @org.groups.build :display_name => 'Owners'
    new_group.valid?.should be_true
  end

  it "must not allow duplicate group names within an org" do
    new_group = @org.groups.build :display_name => 'Owners'
    new_group.save
    new_group2 = @org.groups.build :display_name => 'Owners'
    new_group2.valid?.should be_false

    @org2 = Org.create! :display_name => 'VMWare', :creator => @user
    new_group2.org = @org2
    new_group2.valid?.should be_true
  end

end
