require 'spec_helper'

describe "mapas/show" do
  before(:each) do
    @mapa = assign(:mapa, stub_model(Mapa))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
