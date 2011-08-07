require 'spec_helper'

describe Org do

  context "before creation" do
    it "requires a creator" do
      pending "TODO"
    end

    it "requires a valid name"  do
      org = Org.new
      org.valid?.should be_false

      org.display_name = "VMWare"
      org.valid?.should be_true
    end
  end

  context "after creation" do
    it "must have a default project" do
      pending "TODO"
    end

    it "must have a default admin group" do
     pending "TODO"
    end

    it "creator must be in default admin group" do
     pending "TODO"
    end

    it "must have a default development group" do
     pending "TODO"
    end

    it "creator must not be in default development group" do
     pending "TODO"
    end

    it "creator must be able to edit development group" do
     pending "TODO"
    end
  end
end
