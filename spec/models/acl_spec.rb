require 'spec_helper'

describe Acl do
  before(:each) do
    @user = User.create! :first_name => 'Monica', :last_name => 'Wilkinson', :display_name => 'Monica W'
    @app = App.create! :display_name => 'Optimus'

    @org = Org.create! :display_name => 'VMWare'
    @project = @org.projects.build :display_name => 'CF'
    @project.save!
    @owned_resource = @org.owned_resources.build :resource => @app
    @owned_resource.save!
    @acl = @project.acls.build :owned_resource => @owned_resource, :entity => @user
    @acl.save!
  end

  it "can be instantiated" do
    @acl.should be_an_instance_of(Acl)
  end

  it "gets saved" do
    @acl.reload.id.should_not be_nil
  end

  it "defaults to no permissions" do
    @acl.read?.should be_false
    @acl.update?.should be_false
    @acl.create?.should be_false
    @acl.delete?.should be_false
  end

  it "can toggle permissions" do
    @acl.update!
    @acl.update?.should be_true
    @acl.read! false
    @acl.read?.should be_false
    @acl.update?.should be_true
    @acl.update! false
    @acl.update?.should be_false
  end
end
