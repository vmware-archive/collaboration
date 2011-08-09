# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

@user = User.create! :first_name => 'Monica', :last_name => 'Wilkinson', :display_name => 'Monica W'
@app = App.create! :display_name => 'Cloud Controller'
@service = Service.create! :display_name => 'Cloud Svc'


@org = Org.create! :display_name => 'VMWare'
@project = @org.projects.build :display_name => 'Cloud Foundry'
@project.save!

@group = @org.groups.build :display_name => 'All employees'
@group.save!

@group_member = @group.group_members.build :user => @user
@group_member.save!

@owned_resource = @org.owned_resources.build :resource => @app
@owned_resource.save!


@acl = @project.acls.build :owned_resource => @owned_resource, :entity => @user
@acl.save!