require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the HomeHelper. For example:
#
# describe HomeHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe OrgsHelper do
  before(:each) do
    @pwd = 'cloud$'
    @user = User.create! :first_name => 'Peter', :last_name => 'Smith', :display_name => 'PS', :password => @pwd, :confirm_password => @pwd, :email => 'pete@vmware.com'
    @org = Org.create! :display_name => 'VMWare', :creator => @user
  end

  describe "Generating drop downs" do
    it "must properly list all of the available resources" do
      app = App.create! :display_name => 'Rocket Launcher', :creator => @user, :project => @org.default_project, :url => "rl.cloudfoundry.com"
      @org = @org.reload
      potential_owned_resources(@org).should == [['Use Route', ''], ["#{app.main_owned_resource}", app.main_owned_resource.id]]
    end

    it "must properly list the available groups" do
      @org = @org.reload
      admins = @org.groups.find_by_display_name 'Admins'
      devs = @org.groups.find_by_display_name 'Developers'
      potential_groups(@org).should == [[admins.display_name, admins.id], [devs.display_name, devs.id]]
    end

    it "must properly list all of the available users" do
      devs = @org.groups.find_by_display_name 'Developers'
      new_user = User.create! :first_name => 'Monica', :last_name => 'Wilkinson', :display_name => 'Monica W.', :password => @pwd, :confirm_password => @pwd, :email => 'monica@vmware.com'
      devs.group_members.build :user => new_user
      devs.save!
      @org = @org.reload
      potential_users(@org).should == [[@user.display_name, @user.id], [new_user.display_name, new_user.id]]
    end
  end
end
