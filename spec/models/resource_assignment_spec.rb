require 'spec_helper'

describe ResourceAssignment do
  before(:each) do
    @resource_assignment = ResourceAssignment.new
  end

  it "can be instantiated" do
    @resource_assignment.should be_an_instance_of(ResourceAssignment)
  end

  it "defaults to no permissions" do
    @resource_assignment.read?.should be_false
    @resource_assignment.update?.should be_false
    @resource_assignment.create?.should be_false
    @resource_assignment.delete?.should be_false
  end

  it "can toggle permissions" do
    @resource_assignment.update!
    @resource_assignment.update?.should be_true
    @resource_assignment.read! false
    @resource_assignment.read?.should be_false
    @resource_assignment.update?.should be_true
    @resource_assignment.update! false
    @resource_assignment.update?.should be_false
  end
end
