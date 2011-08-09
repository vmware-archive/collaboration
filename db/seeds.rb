# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# pwc = cloud$
pwd = 'cloud$'
@user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
@service = Service.create! :display_name => 'Identity Service'

@user2 = User.create! :first_name => 'Monica', :last_name => 'Wilkinson', :display_name => 'Monica W.', :password => pwd, :confirm_password => pwd, :email => 'mwilkinson@vmware.com'
@app = App.create! :display_name => 'Collaborate'

@org = Org.create! :display_name => 'VMWare'
@group = @org.groups.build :display_name => 'All employees'
@group.save!
@group_member = @group.group_members.build :user => @user
@group_member.save!
@group_member2 = @group.group_members.build :user => @user2
@group_member2.save!


@project = @org.projects.build :display_name => 'Default'
@project.save!
@owned_resource = @org.owned_resources.build :resource => @app
@owned_resource.save!
@owned_resource2 = @org.owned_resources.build :resource => @service
@owned_resource2.save!

@acl = @project.acls.build :owned_resource => @owned_resource2, :entity => @user, :read_bit => true, :update_bit => true
@acl.save!

@acl2 = @project.acls.build :route => "owned_resource/2/resource", :entity => @user2, :read_bit => true, :update_bit => true
@acl2.save!