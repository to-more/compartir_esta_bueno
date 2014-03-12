require 'spec_helper'

describe "Routers" do
  describe "GET /routers" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get routers_path
      response.status.should be(200)
    end
  end
end
