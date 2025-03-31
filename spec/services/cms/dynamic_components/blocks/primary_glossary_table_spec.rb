require "rails_helper"

RSpec.describe Cms::DynamicComponents::Blocks::PrimaryGlossaryTable do
  before do
    stub_strapi_primary_computing_glossary_table_collection
    @table = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::Blocks::PrimaryGlossaryTable.generate_raw_data
    )
  end

  it "should render as PrimaryGlossaryTableComponent" do
    expect(@table.render).to be_a(Cms::PrimaryGlossaryTableComponent)
  end
end
