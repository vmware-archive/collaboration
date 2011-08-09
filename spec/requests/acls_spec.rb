require 'spec_helper'

describe "Acls" do
  describe "GET /orgs/1/projects/1/acls" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      @org = Org.create! :display_name => 'VMWare'
      @project = @org.projects.build :display_name => 'CF'
      @project.save!
      get org_project_acls_path(@org.id, @project.id)
      response.status.should be(200)
    end
  end
end
