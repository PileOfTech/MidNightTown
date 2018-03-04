require 'rails_helper'

RSpec.describe "import_csvs/new", type: :view do
  before(:each) do
    assign(:import_csv, ImportCsv.new())
  end

  it "renders new import_csv form" do
    render

    assert_select "form[action=?][method=?]", import_csvs_path, "post" do
    end
  end
end
