require 'spec_helper'

describe "orgs/edit.html.erb" do
  before(:each) do
    @org = assign(:org, stub_model(Org,
      :display_name => "MyString",
      :avatar => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit org form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => orgs_path(@org), :method => "post" do
      assert_select "input#org_display_name", :name => "org[display_name]"
      assert_select "input#org_avatar", :name => "org[avatar]"
      assert_select "input#org_description", :name => "org[description]"
    end
  end
end
