require 'spec_helper'

describe Users::AccessTokensController do

  before(:each) do
    pwd = 'cloud$'
    @user = User.create! :first_name => 'Peter', :last_name => 'Smith', :display_name => 'PS', :password => pwd, :confirm_password => pwd, :email => 'ps@vmware.com'
    @ut = UserAccessToken.add_tokens @user.email, 23, :cloudfoundry, {'token' => 'bla'}
    @ut.update_attribute :user_id, @user.id

    @user2 = User.create! :first_name => 'Jane', :last_name => 'Smith', :display_name => 'JS', :password => pwd, :confirm_password => pwd, :email => 'jane@vmware.com'
  end

  after(:each) do
    @ut.destroy
  end

  context "when users match" do
    before(:each) do
      sign_in @user
    end
    describe "GET 'index'" do
      it "should be successful" do
        get :index, :user_id => @user.id
        response.should be_success
        assigns(:tokens).count.should == 1
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested access token" do
        expect {
          delete :destroy, :id => @ut.id.to_s, :user_id => @user.id
        }.to change(UserAccessToken, :count).by(-1)
      end

      it "redirects to the access token list" do
        delete :destroy, :id => @ut.id.to_s, :user_id => @user.id
        response.should redirect_to(user_access_tokens_path(@user))
      end
    end
  end

  context "when users dont match" do
    before(:each) do
      sign_in @user2
    end
    describe "GET 'index'" do
      it "should fail" do
        get :index, :user_id => @user.id
        response.code.should eq("401")
      end
    end

    describe "DELETE destroy" do
      it "should fail" do
        delete :destroy, :id => @ut.id.to_s, :user_id => @user.id
        response.code.should eq("401")
      end
    end
  end
end
