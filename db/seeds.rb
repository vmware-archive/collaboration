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
@user2 = User.create! :first_name => 'Monica', :last_name => 'Wilkinson', :display_name => 'Monica W.', :password => pwd, :confirm_password => pwd, :email => 'mwilkinson@vmware.com'

@org = Org.create! :display_name => 'VMWare', :creator => @user

@group = @org.groups.find_by_display_name 'Admins'
@group_member = @group.group_members.build :user => @user
@group_member.save!
@group_member2 = @group.group_members.build :user => @user2
@group_member2.save!

@service = Service.create! :display_name => 'Identity Service', :creator => @user, :project => @org.default_project
@app = App.create! :display_name => 'Collaborate', :creator => @user2, :project => @org.default_project
