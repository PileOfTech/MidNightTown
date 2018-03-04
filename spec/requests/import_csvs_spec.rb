require 'rails_helper'

RSpec.describe "ImportCsvs", type: :request do
  describe "GET /import_csvs" do
    it "works! (now write some real specs)" do
      get import_csvs_path
      expect(response).to have_http_status(200)
    end
  end
end
