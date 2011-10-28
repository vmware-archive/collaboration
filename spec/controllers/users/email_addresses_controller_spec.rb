require 'spec_helper'

describe Users::EmailAddressesController do

  before(:each) do
    pwd = 'cloud$'
    @user = User.create! :first_name => 'Peter', :last_name => 'Smith', :display_name => 'PS', :password => pwd, :confirm_password => pwd, :email => 'ps@vmware.com'
    @user2 = User.create! :first_name => 'Jane', :last_name => 'Smith', :display_name => 'JS', :password => pwd, :confirm_password => pwd, :email => 'jane@vmware.com'
  end

  describe "GET 'index'" do
    it "should be successful when users match" do
      sign_in @user
      get :index, :user_id => @user.id
      response.should be_success
      assigns(:emails).count.should == 1
    end

    it "should fail when users dont match" do
      sign_in @user2
      get :index, :user_id => @user.id
      response.code.should eq("401")
    end
  end

end
