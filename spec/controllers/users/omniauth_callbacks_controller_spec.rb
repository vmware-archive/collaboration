require 'spec_helper'

describe Users::OmniauthCallbacksController do
  include Devise::TestHelpers

  before(:each) do
    OmniAuth.config.test_mode = true

    @cloudfoundry_hash = {
        'provider' => 'cloudfoundry',
        'user_info' => {
          'email' => 'test@vmware.com'
        },
        'credentials' => {
            'token' => "ewiewuoirwoierjewirjhewkrne"
        }
    }
    @facebook_hash = {
        'provider' => 'facebook',
        'user_info' => {
          'email' => 'test@vmware.com'
        },
        'credentials' => {
            'token' => "ewiewuoirwoierjewirjhewkrne"
        }
    }
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  context "with existing user in db" do
    before(:each) do
      pwd = 'cloud$'
      @user = User.create! :first_name => 'Test', :last_name => 'Testing', :display_name => 'Tester', :password => pwd, :confirm_password => pwd, :email => 'test@vmware.com'
    end

    describe "GET facebook endpoint directly" do
      it "should redirect the user to sign up" do
        get :facebook
        assert_redirected_to new_user_session_path
      end
    end

    describe "GET facebook with matching data" do
      before(:each) do
        env = { "omniauth.auth" =>  @facebook_hash }
        @controller.stub!(:env).and_return(env)
        get :facebook
      end

      it  "should find the user by email" do
        assert_redirected_to root_path
        assert_match flash[:notice], /Successfully authorized from facebook account/
      end

      it {should be_user_signed_in}

      it "should store the access token for the provider" do
        UserAccessToken.get_access_tokens(@user, :facebook).count.should == 1
      end
    end

    describe "GET cloudfoundry endpoint directly" do
      it "should redirect the user to sign up" do
        get :cloudfoundry
        assert_redirected_to new_user_session_path
      end
    end

    describe "GET cloudfoundry with matching data" do
      before do
        env = { "omniauth.auth" =>  @cloudfoundry_hash }
        @controller.stub!(:env).and_return(env)
        get :cloudfoundry
      end

      it  "should find the user by email" do
        assert_redirected_to root_path
        assert_match flash[:notice], /Successfully authorized from cloudfoundry account/
      end

      it {should be_user_signed_in}

      it "should store the access token for the provider" do
        UserAccessToken.get_access_tokens(@user, :cloudfoundry).count.should == 1
      end
    end
  end
end
