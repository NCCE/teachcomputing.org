require "rails_helper"

RSpec.describe Diagnostics::CSAcceleratorController do
  let(:user) { create(:user) }
  let!(:programme) { create(:cs_accelerator) }
  let(:cs_accelerator_questionnaire) do
    create(:questionnaire, :cs_accelerator_enrolment_questionnaire, programme: programme)
  end
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user: user, programme: programme) }

  describe "GET show" do
    before do
      cs_accelerator_questionnaire
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    end

    context "when the user has not completed the diagnostic" do
      before do
        user_programme_enrolment
        get diagnostic_cs_accelerator_certificate_path(:question_1)
      end

      it "renders a question" do
        expect(response).to render_template(:questions)
      end

      it "renders the first question" do
        expect(response.body).to include("Question 1 of 5")
      end

      it "asks client not to cache private pages" do
        expect(response.headers["cache-control"]).to eq("no-store")
      end
    end

    context "when the user has completed the diagnostic" do
      before do
        user_programme_enrolment
        answers = create(:questionnaire_response, user: user, questionnaire: cs_accelerator_questionnaire)
        answers.transition_to(:complete)
        get diagnostic_cs_accelerator_certificate_path(:question_1)
      end

      it "redirects to the programme page" do
        expect(response).to redirect_to "/certificate/subject-knowledge"
      end
    end

    context "when the user is not enrolled" do
      it "redirects back to the certificate page" do
        get diagnostic_cs_accelerator_certificate_path(:question_1)
        expect(response).to redirect_to "/subject-knowledge"
      end
    end
  end
end
