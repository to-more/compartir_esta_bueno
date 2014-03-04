require 'spec_helper'

describe "maps/edit" do
  before(:each) do
    @map = assign(:map, stub_model(Map,
      :address => "MyString",
      :latitude => 1.5,
      :longitude => 1.5
    ))
  end

  it "renders the edit map form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", map_path(@map), "post" do
      assert_select "input#map_address[name=?]", "map[address]"
      assert_select "input#map_latitude[name=?]", "map[latitude]"
      assert_select "input#map_longitude[name=?]", "map[longitude]"
    end
  end
end
