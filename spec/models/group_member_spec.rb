require 'spec_helper'

describe GroupMember do
  it "Can only be created with a group and user" do
    group_member = GroupMember.new
    group_member.valid?.should be_false

    org = Org.create! :display_name =>'VMWare'
    group_member.group = Group.create! :display_name => 'Horizon Devs', :org => org
    group_member.user = User.create! :display_name => "Monica"
    group_member.valid?.should be_true
  end
end
