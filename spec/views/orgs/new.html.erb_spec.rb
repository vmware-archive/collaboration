require 'spec_helper'

describe "orgs/new.html.erb" do
  before(:each) do
    assign(:org, stub_model(Org,
      :display_name => "MyString",
      :avatar => "MyString",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new org form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => orgs_path, :method => "post" do
      assert_select "input#org_display_name", :name => "org[display_name]"
      assert_select "input#org_avatar", :name => "org[avatar]"
      assert_select "textarea#org_description", :name => "org[description]"
    end
  end
end
