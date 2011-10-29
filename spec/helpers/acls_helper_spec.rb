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
describe AclsHelper do
  before(:each) do
    pwd = 'cloud$'
    @user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
    @org = Org.create! :display_name => 'VMWare', :creator => @user
    @project = @org.default_project
    @app = App.create! :display_name => 'Optimus', :creator => @user, :project => @project, :url => "optimus.cloudfoundry.com"
    @owned_resource = @app.main_owned_resource

    @org2 = Org.create! :display_name => 'DELL', :creator => @user
    @project2 = @org2.default_project

    @acl = @project.acls.build :owned_resource => @owned_resource, :entity => @user
    @acl.save!
  end

  context "on read" do
    describe "rendering urls" do
      it "Should return the proper app path if owned resource is app" do
        resource_url(@acl).should == "/apps/#{@app.id}"
      end

      it "Should return the proper service path if owned resource is service" do
        s = Service.create! :display_name => 'Optimus', :project => @project, :creator => @user
        service_res = s.reload.main_owned_resource
        acl2 = @project.acls.build :owned_resource => service_res, :entity => @user
        acl2.save!

        resource_url(acl2).should == "/services/#{s.id}"
      end


      it "Should return the proper parent path if route used" do
        acl3 = @project.acls.build :route => 'projects/*', :entity => @user
        acl3.save!

        resource_url(acl3).should == "/orgs/#{@org.id}/projects/"
      end
    end
  end
end
