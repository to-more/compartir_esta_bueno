require 'spec_helper'

describe "routers/show" do
  before(:each) do
    @router = assign(:router, stub_model(Router,
      :mac => "Mac",
      :essid => "Essid",
      :online => false,
      :ip => "Ip"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Mac/)
    rendered.should match(/Essid/)
    rendered.should match(/false/)
    rendered.should match(/Ip/)
  end
end
