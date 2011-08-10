require 'spec_helper'

describe "users/show.html.erb" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :first_name => "Monica",
      :last_name => "Wilkinson",
      :username => "ciberch",
      :password => 'sasasasa',
      :confirm_password => 'sasasasa',
      :email => 'monica@vmware.com'
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Monica/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Wilkinson/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/ciberch/)
  end
end
