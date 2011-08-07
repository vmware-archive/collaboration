require 'spec_helper'

describe "Projects" do
  describe "GET /orgs/1/projects" do
    it "works! (now write some real specs)" do
      @org = Org.create! :display_name => 'foo'
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get projects_path @org
      response.status.should be(200)
    end
  end
end
