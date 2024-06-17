require "rails_helper"

RSpec.describe Curriculum::FileRedirectController do
  describe "GET #redirect_to_file" do
    let(:slug) { "primary-journey-progress-icon" }
    let(:file_url) { "http://curriculum.teachcomputing.org/rails/active_storage/blobs/redirect/test_icon.jpeg" }
    let(:file_upload) { OpenStruct.new(file: file_url) }

    context "when the file exists" do
      before do
        allow(CurriculumClient::Queries::FileUpload).to receive(:one).and_return(OpenStruct.new(file_upload: file_upload))
      end

      it "redirects to the file URL" do
        get curriculum_file_redirect_path(slug: slug)

        expect(response).to redirect_to(file_url)
      end
    end

    context "when the file does not exist" do
      before do
        allow(CurriculumClient::Queries::FileUpload).to receive(:one).and_return(OpenStruct.new(file_upload: nil))
      end

      it "returns a 404 status with a 'File not found' message" do
        get curriculum_file_redirect_path(slug: slug)

        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("File not found")
      end
    end
  end
end
