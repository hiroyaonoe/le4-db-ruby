require "rails_helper"

RSpec.describe BoardsController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(get: "/boards/1").to route_to("boards#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/boards").to route_to("boards#create")
    end

    it "routes to #destroy" do
      expect(delete: "/boards/1").to route_to("boards#destroy", id: "1")
    end
  end
end
