require 'spec_helper'

describe "mapas/edit" do
  before(:each) do
    @mapa = assign(:mapa, stub_model(Mapa))
  end

  it "renders the edit mapa form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", mapa_path(@mapa), "post" do
    end
  end
end
