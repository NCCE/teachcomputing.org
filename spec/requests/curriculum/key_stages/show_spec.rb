require "rails_helper"

RSpec.describe Curriculum::KeyStagesController do
  let(:key_stage_json_response) { File.new("spec/support/curriculum/responses/key_stage.json").read }

  describe "GET #show" do
    before do
      client = CurriculumClient::Connection.connect(ENV.fetch("CURRICULUM_TEST_SCHEMA_PATH"))
      allow(CurriculumClient::Connection).to receive(:connect).and_return(client)
    end

    context "when curriculum is enabled" do
      it "renders the show template" do
        stub_a_valid_request(key_stage_json_response)
        get curriculum_key_stage_units_path(key_stage_slug: "key-stage-1")
        expect(response).to render_template(:show)
      end
    end
  end
end
