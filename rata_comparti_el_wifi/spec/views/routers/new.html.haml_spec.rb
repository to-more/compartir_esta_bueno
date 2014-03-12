require 'spec_helper'

describe "routers/new" do
  before(:each) do
    assign(:router, stub_model(Router,
      :mac => "MyString",
      :essid => "MyString",
      :online => false,
      :ip => "MyString"
    ).as_new_record)
  end

  it "renders new router form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", routers_path, "post" do
      assert_select "input#router_mac[name=?]", "router[mac]"
      assert_select "input#router_essid[name=?]", "router[essid]"
      assert_select "input#router_online[name=?]", "router[online]"
      assert_select "input#router_ip[name=?]", "router[ip]"
    end
  end
end
