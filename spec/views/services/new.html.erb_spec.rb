require 'spec_helper'

describe "services/new.html.erb" do
  before(:each) do
    assign(:service, stub_model(Service,
      :display_name => "MyString",
      :url => "MyString"
    ).as_new_record)
  end

  it "renders new service form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => services_path, :method => "post" do
      assert_select "input#service_display_name", :name => "service[display_name]"
      assert_select "input#service_url", :name => "service[url]"
    end
  end
end
