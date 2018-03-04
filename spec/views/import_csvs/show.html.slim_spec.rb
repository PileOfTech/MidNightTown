require 'rails_helper'

RSpec.describe "import_csvs/show", type: :view do
  before(:each) do
    @import_csv = assign(:import_csv, ImportCsv.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
