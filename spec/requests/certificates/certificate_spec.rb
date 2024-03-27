require "rails_helper"

RSpec.describe Certificates::CertificateController do
  let(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }
  let(:assessment) { create(:assessment, programme: programme) }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
      user_id: user.id,
      programme_id: programme.id)
  end
  let(:exam_activity) { create(:activity, :cs_accelerator_exam) }
  let(:programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: exam_activity.id) }
  let(:passed_exam) { create(:achievement, user_id: user.id, activity_id: exam_activity.id) }
  let(:passed_attempt) { create(:completed_assessment_attempt, user_id: user.id, assessment_id: assessment.id) }

  describe "#certificate" do
    describe "while logged in" do
      before do
        programme
        allow_any_instance_of(AuthenticationHelper)
          .to receive(:current_user).and_return(user)
      end

      it "redirects if not enrolled" do
        get certificate_cs_accelerator_certificate_path
        expect(response).to redirect_to(cs_accelerator_certificate_path)
      end

      describe "and enrolled" do
        before do
          user_programme_enrolment
          get certificate_cs_accelerator_certificate_path
        end

        it "redirects if not complete" do
          expect(response).to redirect_to(cs_accelerator_certificate_path)
        end
      end

      describe "and complete" do
        before do
          generator_double = instance_double(::CertificateGenerator)
          allow(generator_double)
            .to receive(:generate_pdf)
            .and_return({path: "spec/support/example_certificate.pdf", filename: "test-certificate.pdf"})
          allow(CertificateGenerator).to receive(:new) { generator_double }

          programme_activity
          passed_attempt
          passed_exam.complete!
          user_programme_enrolment.transition_to(:complete, certificate_number: 20)
          get certificate_cs_accelerator_certificate_path
        end

        it "shows the page if complete" do
          expect(response).to have_http_status(:ok)
        end

        it "responds with inline pdf file" do
          expect(response.content_type).to eq("application/pdf")
          expect(response.headers["Content-Disposition"])
            .to eq("inline; filename=\"test-certificate.pdf\"; filename*=UTF-8''test-certificate.pdf")
        end

        it "asks client not to cache private pages" do
          expect(response.headers["cache-control"]).to eq("no-store")
        end
      end
    end

    describe "while logged out" do
      before do
        get certificate_cs_accelerator_certificate_path
      end

      it "redirects to login" do
        expect(response).to redirect_to(/register/)
      end
    end
  end
end
