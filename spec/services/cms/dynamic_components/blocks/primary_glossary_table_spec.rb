require "rails_helper"

RSpec.describe Cms::DynamicComponents::Blocks::PrimaryGlossaryTable do
  before do
    stub_strapi_primary_computing_glossary_table_collection
    @text = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(Cms::Mocks::DynamicComponents::PrimaryGlossaryTable.generate_raw_data)
  end

  it "should render as PrimaryGlossaryTableComponent" do
    expect(@text.render).to be_a(Cms::PrimaryGlossaryTableComponent)
  end
end
