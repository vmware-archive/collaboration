require 'spec_helper'

describe "organizations/edit.html.erb" do
  before(:each) do
    @organization = assign(:organization, stub_model(Organization,
      :display_name => "MyString",
      :avatar => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit organization form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => organizations_path(@organization), :method => "post" do
      assert_select "input#organization_display_name", :name => "organization[display_name]"
      assert_select "input#organization_avatar", :name => "organization[avatar]"
      assert_select "input#organization_description", :name => "organization[description]"
    end
  end
end
