require 'spec_helper'

describe "nodes/new" do
  before(:each) do
    assign(:node, stub_model(Node,
      :router => "",
      :location => "",
      :link => ""
    ).as_new_record)
  end

  it "renders new node form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", nodes_path, "post" do
      assert_select "input#node_router[name=?]", "node[router]"
      assert_select "input#node_location[name=?]", "node[location]"
      assert_select "input#node_link[name=?]", "node[link]"
    end
  end
end
