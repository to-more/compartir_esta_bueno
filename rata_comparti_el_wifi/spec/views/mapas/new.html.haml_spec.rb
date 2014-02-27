require 'spec_helper'

describe "mapas/new" do
  before(:each) do
    assign(:mapa, stub_model(Mapa).as_new_record)
  end

  it "renders new mapa form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", mapas_path, "post" do
    end
  end
end
