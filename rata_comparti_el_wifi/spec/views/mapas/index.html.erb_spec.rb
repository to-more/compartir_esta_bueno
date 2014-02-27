require 'spec_helper'

describe "mapas/index" do
  before(:each) do
    assign(:mapas, [
      stub_model(Mapa),
      stub_model(Mapa)
    ])
  end

  it "renders a list of mapas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
