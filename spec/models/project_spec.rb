require 'spec_helper'

describe Project do
  before(:each) do
    @organization = Organization.new :display_name => 'VMWare'
    @project = @organization.projects.build
  end

  it "should be instantiated" do
    @project.should be_an_instance_of(Project)
  end
end
