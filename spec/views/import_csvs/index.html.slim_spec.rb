require 'rails_helper'

RSpec.describe "import_csvs/index", type: :view do
  before(:each) do
    assign(:import_csvs, [
      ImportCsv.create!(),
      ImportCsv.create!()
    ])
  end

  it "renders a list of import_csvs" do
    render
  end
end
