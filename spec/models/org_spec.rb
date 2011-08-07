require 'spec_helper'

describe Org do
  it "requires a valid name"  do
    org = Org.new
    org.valid?.should be_false
  end

end
