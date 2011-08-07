require 'spec_helper'

describe Project do
  before(:each) do
    @org = Org.new :display_name => 'VMWare'
    @project = @org.projects.build
  end

  it "should be instantiated" do
    @project.should be_an_instance_of(Project)
  end
end
