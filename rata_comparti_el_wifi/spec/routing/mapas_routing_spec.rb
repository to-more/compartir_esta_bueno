require "spec_helper"

describe MapasController do
  describe "routing" do

    it "routes to #index" do
      get("/mapas").should route_to("mapas#index")
    end

    it "routes to #new" do
      get("/mapas/new").should route_to("mapas#new")
    end

    it "routes to #show" do
      get("/mapas/1").should route_to("mapas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/mapas/1/edit").should route_to("mapas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/mapas").should route_to("mapas#create")
    end

    it "routes to #update" do
      put("/mapas/1").should route_to("mapas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/mapas/1").should route_to("mapas#destroy", :id => "1")
    end

  end
end
