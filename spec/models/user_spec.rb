require 'spec_helper'

describe User do
  it "can be instantiated" do
    new_user = User.new :first_name => 'Monica', :last_name => 'Wilkinson'
    new_user.should be_an_instance_of(User)
  end

end