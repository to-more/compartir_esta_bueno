require "spec_helper"

describe RoutersController do
  describe "routing" do

    it "routes to #index" do
      get("/routers").should route_to("routers#index")
    end

    it "routes to #new" do
      get("/routers/new").should route_to("routers#new")
    end

    it "routes to #show" do
      get("/routers/1").should route_to("routers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/routers/1/edit").should route_to("routers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/routers").should route_to("routers#create")
    end

    it "routes to #update" do
      put("/routers/1").should route_to("routers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/routers/1").should route_to("routers#destroy", :id => "1")
    end

  end
end
