require 'spec_helper'

describe "nodes/edit" do
  before(:each) do
    @node = assign(:node, stub_model(Node,
      :router => "",
      :location => "",
      :link => ""
    ))
  end

  it "renders the edit node form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", node_path(@node), "post" do
      assert_select "input#node_router[name=?]", "node[router]"
      assert_select "input#node_location[name=?]", "node[location]"
      assert_select "input#node_link[name=?]", "node[link]"
    end
  end
end
