require 'spec_helper'

describe Org do
  before(:each) do
    @pwd = 'cloud$'
    @user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => @pwd, :confirm_password => @pwd, :email => 'dale@vmware.com'
  end

  after(:each) do
    @user.delete
  end

  context "before creation" do
    it "requires a creator" do
      lambda {Org.create! :display_name => 'NASA'}.should raise_error
    end

    it "requires a valid name"  do
      org = Org.new

      org.creator = @user
      org.valid?.should be_false
      org.display_name = "VMWare"
      org.valid?.should be_true
    end
  end

  context "after creation" do
    before(:each) do
      @org = Org.create! :display_name => 'NASA', :creator => @user
    end

    it "must have a default project" do
      @org.reload.projects.count.should == 1
    end

    it "must have a default admin group" do
      admins = @org.reload.groups.find_by_display_name 'Admins'
      admins.should_not be_nil
    end

    it "creator must be in default admin group" do
      admins = @org.reload.groups.find_by_display_name 'Admins'
      admins.group_members.count.should == 1
      admins.group_members.first.user.should == @user
    end

    it "must have a default development group" do
      devs = @org.reload.groups.find_by_display_name 'Developers'
      devs.should_not be_nil
    end

    it "creator should be in default development group" do
      devs = @org.reload.groups.find_by_display_name 'Developers'
      devs.group_members.count.should == 1
    end

    it "creator must be able to edit development group" do
      @org.default_project.acls.count.should > 0
     @org.can_user(PermissionManager::CREATE, "groups/*/group_members", @user).should be_true
    end
  end
end
