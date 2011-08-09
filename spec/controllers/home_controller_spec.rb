require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "should be successful" do
      pwd = 'cloud$'
      @user = User.create! :first_name => 'Dale', :last_name => 'Olds', :display_name => 'Dale O.', :password => pwd, :confirm_password => pwd, :email => 'olds@vmware.com'
      sign_in @user
      get 'index'
      response.should be_success
    end
  end

end
