require 'spec_helper'

describe GroupMember do
  it "Can only be created with a group and user" do
    pwd = 'cloud$'
    user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'

    group_member = GroupMember.new
    group_member.valid?.should be_false

    org = Org.create! :display_name =>'VMWare', :creator => user
    group = Group.create! :display_name => 'Horizon Devs', :org => org
    group_member = group.group_members.build :user => user
    group_member.valid?.should be_true
  end
end
