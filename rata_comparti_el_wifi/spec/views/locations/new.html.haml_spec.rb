require 'spec_helper'

describe "locations/new" do
  before(:each) do
    assign(:location, stub_model(Location,
      :ip => "",
      :address => "",
      :latitude => "",
      :longitude => ""
    ).as_new_record)
  end

  it "renders new location form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", locations_path, "post" do
      assert_select "input#location_ip[name=?]", "location[ip]"
      assert_select "input#location_address[name=?]", "location[address]"
      assert_select "input#location_latitude[name=?]", "location[latitude]"
      assert_select "input#location_longitude[name=?]", "location[longitude]"
    end
  end
end
