require 'spec_helper'

describe "routers/edit" do
  before(:each) do
    @router = assign(:router, stub_model(Router,
      :mac => "MyString",
      :essid => "MyString",
      :online => false,
      :ip => "MyString"
    ))
  end

  it "renders the edit router form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", router_path(@router), "post" do
      assert_select "input#router_mac[name=?]", "router[mac]"
      assert_select "input#router_essid[name=?]", "router[essid]"
      assert_select "input#router_online[name=?]", "router[online]"
      assert_select "input#router_ip[name=?]", "router[ip]"
    end
  end
end
