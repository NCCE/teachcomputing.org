require "rails_helper"

RSpec.describe Cms::Models::DynamicComponents::Blocks::CurriculumKeyStages do
  let(:key_stages_json_response) { File.new("spec/support/curriculum/responses/key_stages.json").read }

  before do
    client = CurriculumClient::Connection.connect(ENV.fetch("CURRICULUM_TEST_SCHEMA_PATH"))
    allow(CurriculumClient::Connection).to receive(:connect).and_return(client)
    stub_a_valid_request(key_stages_json_response)
    @comp = Cms::Providers::Strapi::Factories::ComponentFactory.process_component(
      Cms::Mocks::DynamicComponents::Blocks::CurriculumKeyStages.generate_raw_data
    )
  end

  it "should render as Cms::CurriculumKeyStagesComponent" do
    expect(@comp.render).to be_a(Cms::CurriculumKeyStagesComponent)
  end
end
