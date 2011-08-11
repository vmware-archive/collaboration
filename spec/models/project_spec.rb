require 'spec_helper'

describe Project do
  before(:each) do
    pwd = 'cloud$'
    @user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'dale@vmware.com'
    @org = Org.create! :display_name => 'NASA', :creator => @user
    @project = @org.default_project
  end

  it "should be instantiated" do
    project = @org.projects.build
    project.should be_an_instance_of(Project)
  end


  it "can be saved" do
    project = @org.projects.build :display_name => 'Socialcast'
    project.save

    project.reload.id.should_not be_nil
  end

  it "must have a display name to be valid" do
    project = @org.projects.build
    project.valid?.should_not be_true

    project = @org.projects.build :display_name => 'Horizon'
    project.valid?.should be_true
  end

  it "must not allow duplicate group names within an org" do
    new_project = @org.projects.build :display_name => 'SC'
    new_project.save
    new_project2 = @org.projects.build :display_name => 'SC'
    new_project2.valid?.should be_false

    @org2 = Org.create! :display_name => 'VMWare', :creator => @user
    new_project2.org = @org2
    new_project2.valid?.should be_true
  end

end
