require 'spec_helper'

describe ResourceAssignment do
  before(:each) do
    @resource_assignment = ResourceAssignment.new
  end

  it "can be instantiated" do
    @resource_assignment.should be_an_instance_of(ResourceAssignment)
  end

  it "defaults to no permissions" do
    @resource_assignment.read?.should == false
    @resource_assignment.write?.should == false
    @resource_assignment.delete?.should == false
  end

  it "can toggle permissions" do
    @resource_assignment.write!
    @resource_assignment.write?.should == true
    @resource_assignment.read! false
    @resource_assignment.read?.should == false
    @resource_assignment.write?.should == true
    @resource_assignment.write! false
    @resource_assignment.write?.should == false
  end
end
