require "rails_helper"

RSpec.describe Curriculum::LessonsController do
  let(:lesson_json_response) { File.new("spec/support/curriculum/responses/lesson.json").read }

  describe "GET #show" do
    before do
      client = CurriculumClient::Connection.connect(ENV.fetch("CURRICULUM_TEST_SCHEMA_PATH"))
      allow(CurriculumClient::Connection).to receive(:connect).and_return(client)
    end

    it "renders the show template" do
      stub_a_valid_request_with_redirect(lesson_json_response)

      get curriculum_key_stage_unit_lesson_path(
        key_stage_slug: "key-stage-3",
        unit_slug: "representations-from-clay-to-silicon",
        lesson_slug: "lesson-1-across-time-and-space"
      )
      expect(response).to render_template(:show)
    end

    it "404s when the lesson slug does not exist" do
      stub_an_invalid_request
      expect do
        get curriculum_key_stage_unit_lesson_path(
          key_stage_slug: "key-stage-3",
          unit_slug: "representations-from-clay-to-silicon",
          lesson_slug: "a-dud"
        )
      end.to raise_error(Graphlient::Errors::FaradayServerError)
    end
  end
end
