require "rails_helper"

RSpec.describe Curriculum::KeyStagesController do
  let(:key_stages_json_response) { File.new("spec/support/curriculum/responses/key_stages.json").read }

  describe "GET #index" do
    before do
      client = CurriculumClient::Connection.connect(ENV.fetch("CURRICULUM_TEST_SCHEMA_PATH"))
      allow(CurriculumClient::Connection).to receive(:connect).and_return(client)

      file_client = double("file_client")
      allow(CurriculumClient::Queries::FileUpload).to receive(:one).and_return(file_client)

      allow(file_client).to receive(:file_upload).and_return(
        journey_progress_file(slug: "journey-progress-pdf", file_type: "pdf"),
        journey_progress_file(slug: "journey-progress-icon", file_type: "icon"),
        journey_progress_file(slug: "primary-journey-progress-pdf", file_type: "pdf"),
        journey_progress_file(slug: "secondary-journey-progress-pdf", file_type: "pdf")
      )
    end

    context "when curriculum is enabled" do
      before do
        stub_a_valid_request(key_stages_json_response)
      end

      it "renders the index template" do
        get curriculum_key_stages_path
        expect(response).to render_template(:index)
        expect(assigns(:journey_progress_pdf)).to be_present
        expect(assigns(:journey_progress_icon)).to be_present
        expect(assigns(:primary_journey_progress_pdf)).to be_present
        expect(assigns(:secondary_journey_progress_pdf)).to be_present
      end
    end

    private

    def journey_progress_file(slug:, file_type:)
      extension = (file_type == "pdf") ? "pdf" : "png"

      OpenStruct.new({
        name: "Journey progress test file",
        file: "media/images/test/example.#{extension}",
        slug: slug
      })
    end
  end
end
