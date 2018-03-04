require "rails_helper"

RSpec.describe ImportCsvsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/import_csvs").to route_to("import_csvs#index")
    end

    it "routes to #new" do
      expect(:get => "/import_csvs/new").to route_to("import_csvs#new")
    end

    it "routes to #show" do
      expect(:get => "/import_csvs/1").to route_to("import_csvs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/import_csvs/1/edit").to route_to("import_csvs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/import_csvs").to route_to("import_csvs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/import_csvs/1").to route_to("import_csvs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/import_csvs/1").to route_to("import_csvs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/import_csvs/1").to route_to("import_csvs#destroy", :id => "1")
    end

  end
end
