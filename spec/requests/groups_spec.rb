require 'spec_helper'

describe "Groups" do
  describe "GET /orgs/:id/groups" do
    it "works (now write some real specs)" do
      @org = Organization.create! :display_name => 'foo'
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      #get groups_organization_path @org
      #response.status.should be(200)
      pending "find the path"
    end
  end
end
