require 'spec_helper'

describe User do
  it "can be instantiated" do
    new_user = User.new :first_name => 'Monica', :last_name => 'Wilkinson'
    new_user.should be_an_instance_of(User)
  end

  it "requires email and password" do
    pwd = 'cloud$'
    user = User.create!  :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
    user.reload.id.should_not be_nil
  end

  it "requires unique email addresses" do
   pwd = 'cloud$'
    user = User.create!  :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
    user.reload.id.should_not be_nil

    user2 = User.new :first_name => 'Dale', :last_name => 'Olds 2', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
    user2.valid?.should be_false
  end

  context "with CF Single Sign On" do
    before(:each) do
      @env = {}
      @env["omniauth.auth"] = {}
      @creds = {}
      @creds['token'] = "wehiqhejqkhejkqheqjkehq"
      @creds['refresh_token'] = "165354f3vhdjdk"
      @env["omniauth.auth"]["credentials"] = @creds

      @env["omniauth.auth"]['user_info'] = {}
      @env["omniauth.auth"]['user_info']['email'] = "another@mail.com"

      @ut = UserAccessToken.add_tokens @env["omniauth.auth"]['user_info']['email'], 23, :cloudfoundry, @creds

    end



    it "SSO finds user by email" do
      pwd = 'cloud$'
      @user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'

      @sso_user = User.get_user_from_auth_by_email('olds@vmware.com', nil)
      @sso_user.should == @user


    end

    it "SSO Defaults to signed in user" do
      pwd = 'cloud$'
      @user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
      @sso_user = User.get_user_from_auth_by_email("another@mail.com", @user)
      @sso_user.id.should == @user.id

      @ut.update_attribute :user_id, @user.id

      UserAccessToken.first_access_token(@user, :cloudfoundry).should_not be_nil
    end

    it "SSO creates new user if no logged in user" do
      @sso_user = User.get_user_from_auth_by_email("another@mail.com", nil)
      @sso_user.persisted?.should be_false
    end
  end


  it "creates a personal org for the user" do
    pwd = 'cloud$'
    user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
    user.reload.id.should_not be_nil
    Org.all.count.should == 1
    user.personal_org.should_not be_nil
  end

  it "properly selects the orgs it has access to" do
    pwd = 'cloud$'
    user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
    user.orgs_with_access.should eq([user.personal_org])

    org2 = Org.create! :display_name => "NASA", :creator => user
    user.reload.orgs_with_access.should eq([user.personal_org, org2])
  end

end