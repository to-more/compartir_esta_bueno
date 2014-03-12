require 'spec_helper'

describe "routers/index" do
  before(:each) do
    assign(:routers, [
      stub_model(Router,
        :mac => "Mac",
        :essid => "Essid",
        :online => false,
        :ip => "Ip"
      ),
      stub_model(Router,
        :mac => "Mac",
        :essid => "Essid",
        :online => false,
        :ip => "Ip"
      )
    ])
  end

  it "renders a list of routers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Mac".to_s, :count => 2
    assert_select "tr>td", :text => "Essid".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Ip".to_s, :count => 2
  end
end
