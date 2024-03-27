require "rails_helper"

RSpec.describe "Admin::UserProgrammeEnrolmentsController" do
  let(:user) { create(:user) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user:) }
  let(:completed_enrolment) { create(:completed_enrolment, user:) }

  before do
    allow_any_instance_of(Admin::ApplicationController).to receive(:authenticate_admin).and_return("user@example.com")
  end

  describe "GET #index" do
    before do
      get admin_user_programme_enrolments_path
    end

    it "should render correct template" do
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    before do
      get admin_user_programme_enrolment_path(user_programme_enrolment)
    end

    it "should render correct template" do
      expect(response).to render_template("show")
    end
  end

  describe "GET #edit" do
    before do
      get edit_admin_user_programme_enrolment_path(user_programme_enrolment)
    end

    it "should render the correct template" do
      expect(response).to render_template("edit")
    end
  end

  describe "PUT #update" do
    context "with valid status" do
      before do
        put admin_user_programme_enrolment_path(user_programme_enrolment, params: {
          user_programme_enrolment: {current_state: :pending}
        })
      end

      it "should redirect to the show page" do
        expect(response).to redirect_to(admin_user_path(user))
        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid status" do
      before do
        put admin_user_programme_enrolment_path(user_programme_enrolment, params: {
          user_programme_enrolment: {current_state: :random}
        })
      end

      it "should redirect to the show page" do
        expect(response).to redirect_to(edit_admin_user_path(user))
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "GET #generate_certificate" do
    before do
      generator_double = instance_double(::CertificateGenerator)
      allow(generator_double)
        .to receive(:generate_pdf)
        .and_return({path: "spec/support/example_certificate.pdf", filename: "test-certificate.pdf"})
      allow(CertificateGenerator).to receive(:new) { generator_double }

      completed_enrolment

      get generate_certificate_admin_user_programme_enrolment_path(completed_enrolment)
    end

    it "shows the page if complete" do
      expect(response).to have_http_status(:ok)
    end

    it "responds with inline pdf file" do
      expect(response.content_type).to eq("application/pdf")
      expect(response.headers["Content-Disposition"])
        .to eq("inline; filename=\"test-certificate.pdf\"; filename*=UTF-8''test-certificate.pdf")
    end
  end
end
