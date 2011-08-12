require 'spec_helper'

describe "users/index.html.erb" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :first_name => "Monica",
      :last_name => "Wilkinson",
      :display_name => 'Monica W.',
      :username => "ciberch",
      :password => 'sasasasa',
      :confirm_password => 'sasasasa',
      :email => 'monica@vmware.com'
      ),
      stub_model(User,
      :first_name => "Monica",
      :last_name => "Wilkinson",
      :display_name => 'Monica W.',
      :username => "ciberch",
      :password => 'sasasasa',
      :confirm_password => 'sasasasa',
      :email => 'monica2@vmware.com'
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "ul>li", :text => "Monica W.".to_s, :count => 2
  end
end
