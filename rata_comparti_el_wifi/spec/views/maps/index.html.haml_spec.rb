require 'spec_helper'

describe "maps/index" do
  before(:each) do
    assign(:maps, [
      stub_model(Map,
        :address => "Address",
        :latitude => 1.5,
        :longitude => 1.5
      ),
      stub_model(Map,
        :address => "Address",
        :latitude => 1.5,
        :longitude => 1.5
      )
    ])
  end

  it "renders a list of maps" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
