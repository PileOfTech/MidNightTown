require 'rails_helper'

RSpec.describe "import_csvs/edit", type: :view do
  before(:each) do
    @import_csv = assign(:import_csv, ImportCsv.create!())
  end

  it "renders the edit import_csv form" do
    render

    assert_select "form[action=?][method=?]", import_csv_path(@import_csv), "post" do
    end
  end
end
