require 'spec_helper'

LOGIN_PROVIDERS = [:facebook, :cloudfoundry]
ALL_PROVIDERS  = [:facebook, :cloudfoundry, :github]

describe Users::OmniauthCallbacksController do
  include Devise::TestHelpers

  before(:each) do
    OmniAuth.config.test_mode = true

    @email = 'test@vmware.com'

    @hash = {}
    @hash[:cloudfoundry] = {
        'provider' => 'cloudfoundry',
        'uid' => 77474,
        'user_info' => {
            'email' => @email
        },
        'credentials' => {
            'token' => "ewiewuoirwoierjewirjhewkrne"
        }
    }
    @hash[:facebook] = {
        'provider' => 'facebook',
        'uid' => '23232323vnvnvn',
        'user_info' => {
            'email' => @email
        },
        'credentials' => {
            'token' => "ewiewuoirwoierjewirjhewkrne"
        }
    }
    @hash[:github] = {
      'provider' => 'github',
      'uid' => 12129819281,
      'user_info' => {
          'urls' => {
              'GitHub' => 'http://github.com/someone'
          }
      },
      'credentials' => {
          'token' => "ewiewuoirwoierjewirjhewkrne"
      }
    }
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "OmniAuth Config" do
    it "should have github, facebook and cloudfoundry as providers" do
      User.omniauth_providers.should == ALL_PROVIDERS
    end
    it "should have only facebook and cloudfoundry as sign in providers" do
      EmailAddress::VERIFIED_EMAIL_PROVIDERS.should == LOGIN_PROVIDERS
    end
  end

  context "URL hacking" do
    describe "GET endpoint directly" do

      ALL_PROVIDERS.each do |provider|
        it "#{provider} endpoint should redirect the user to sign up" do
          get provider
          assert_redirected_to new_user_session_path
          assert_match flash[:notice], /Not enough information to sign in/
        end
      end
    end
  end

  context "with no user in db" do
    describe "GET endpoint with good data" do

      LOGIN_PROVIDERS.each do |provider|
        before(:each) do
          env = {"omniauth.auth" => @hash[provider]}
          @controller.stub!(:env).and_return(env)
          get provider
          @new_user = assigns(:user)
        end

        it "should set the user record" do
          @new_user.should_not be_nil
          @new_user.should_not be_persisted
        end

        it "should prompt the user to finish sign up" do
          assert_redirected_to new_user_registration_url
          assert_match flash[:notice], /Please complete registration to App Gallery/
        end

        it "should store the access token for the provider" do
          UserAccessToken.get_access_tokens(@new_user, provider).count.should == 1
        end
      end
    end
  end

  context "with existing user in db" do
    before(:each) do
      pwd = 'cloud$'
      @user = User.create! :first_name => 'Test', :last_name => 'Testing', :display_name => 'Tester', :password => pwd, :confirm_password => pwd, :email => @email
    end

    describe "GET endpoint with matching data" do

      LOGIN_PROVIDERS.each do |provider|
        before(:each) do
          env = {"omniauth.auth" => @hash[provider]}
          @controller.stub!(:env).and_return(env)
          get provider
        end

        it "should find the user by email" do
          assert_redirected_to root_path
          assert_match flash[:notice], /Successfully authorized from .+ account/
        end

        it { should be_user_signed_in }

        it "should store the access token for the provider" do
          UserAccessToken.get_access_tokens(@user, provider).count.should == 1
        end
      end
    end
  end

  context "with existing user in db and same user signed in" do
    before(:each) do
      pwd = 'cloud$'
      @user = User.create! :first_name => 'Test', :last_name => 'Testing', :display_name => 'Tester', :password => pwd, :confirm_password => pwd, :email => @email
      sign_in @user
    end

    describe "GET endpoint with matching data" do

      ALL_PROVIDERS.each do |provider|
        before(:each) do
          env = {"omniauth.auth" => @hash[provider]}
          @controller.stub!(:env).and_return(env)
          get provider
        end

        it "should find the user by email" do
          assert_redirected_to root_path
          assert_match flash[:notice], /Successfully authorized from .+ account/
        end

        it { should be_user_signed_in }

        it "should store the access token for the provider" do
          UserAccessToken.get_access_tokens(@user, provider).count.should == 1
        end
      end
    end
  end

  context "with existing user in db and different user signed in" do
    before(:each) do
      pwd = 'cloud$'
      @user = User.create! :first_name => 'Test', :last_name => 'Testing', :display_name => 'Tester', :password => pwd, :confirm_password => pwd, :email => @email
      @user2 = User.create! :first_name => 'Bla', :last_name => 'Blah', :display_name => 'Blaher', :password => pwd, :confirm_password => pwd, :email => "Blablah@vmware.com"
      sign_in @user2
    end

    describe "GET endpoint with matching data" do

      ALL_PROVIDERS.each do |provider|
        before(:each) do
          env = {"omniauth.auth" => @hash[provider]}
          @controller.stub!(:env).and_return(env)

          # Fake the fact that the user has already logged in with the external id
          @ut = UserAccessToken.add_tokens nil, @hash[provider]['uid'], provider, @hash[provider]['credentials']
          @ut.update_attribute  :user_id, @user.id

          get provider
        end

        after(:each) do
          @ut.destroy
        end

        it { should be_user_signed_in }

        it "should have the user matching oauth user signed in" do
          assert_redirected_to root_path
          flash[:notice].should == "Switching logged in user to #{@user.display_name}"
        end

        #it "should have the user matching oauth user signed in" do
        #  subject.current_user.should == @user
        #end

        it "should store the access token for the provider" do
          UserAccessToken.get_access_tokens(@user, provider).count.should == 1
        end
      end
    end
  end

  context "with no matching user in db and a user signed in" do
    before(:each) do
      pwd = 'cloud$'
      @user = User.create! :first_name => 'Bla', :last_name => 'Blah', :display_name => 'Blaher', :password => pwd, :confirm_password => pwd, :email => "Blablah@vmware.com"
      sign_in @user
    end

    describe "GET endpoint with proper data" do
      LOGIN_PROVIDERS.each do |provider|
        before(:each) do
          env = {"omniauth.auth" => @hash[provider]}
          @controller.stub!(:env).and_return(env)
          get provider
        end

        it { should be_user_signed_in }

        it "should have the user matching oauth user signed in" do
          subject.current_user.should == @user
        end

        it "should store the access token for the provider" do
          UserAccessToken.get_access_tokens(@user, provider).count.should == 1
        end

        it "should add an alternate email address to the user" do
          @user.reload.email_addresses.collect(&:email).should == [@user.email, @email]
        end

        describe "user signs out" do
          before(:each) do
            sign_out @user
            get provider
          end

          it { should be_user_signed_in }

          it "should have the user matching oauth user signed in" do
            subject.current_user.should == @user
          end

          it "should store the access token for the provider" do
            UserAccessToken.get_access_tokens(@user, provider).count.should == 1
          end
        end
      end
    end
  end
end
