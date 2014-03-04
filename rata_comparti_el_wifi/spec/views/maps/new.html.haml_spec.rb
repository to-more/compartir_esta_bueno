require 'spec_helper'

describe "maps/new" do
  before(:each) do
    assign(:map, stub_model(Map,
      :address => "MyString",
      :latitude => 1.5,
      :longitude => 1.5
    ).as_new_record)
  end

  it "renders new map form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", maps_path, "post" do
      assert_select "input#map_address[name=?]", "map[address]"
      assert_select "input#map_latitude[name=?]", "map[latitude]"
      assert_select "input#map_longitude[name=?]", "map[longitude]"
    end
  end
end
