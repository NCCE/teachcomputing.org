require 'rails_helper'

RSpec.describe Diagnostics::CSAcceleratorController do
  let(:user) { create(:user) }
  let!(:programme) { create(:cs_accelerator) }
  let(:cs_accelerator_questionnaire) do
    create(:questionnaire, :cs_accelerator_enrolment_questionnaire, programme: programme)
  end
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user: user, programme: programme) }

  describe 'GET show' do
    before do
      cs_accelerator_questionnaire
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    end

    # context 'when logged out' do (necessary?)
    # end

    context 'when the user has not completed the diagnostic' do
      before do
        user_programme_enrolment
        get diagnostic_cs_accelerator_certificate_path(:question_1)
      end

      it 'renders the first step in the wizard' do
        expect(response).to render_template(:question_1)
      end
    end

    context 'when the user has completed the diagnostic' do
      before do
        user_programme_enrolment
        answers = create(
          :cs_accelerator_enrolment_score_15,
          questionnaire: cs_accelerator_questionnaire,
          programme: programme, user: user
        )
        answers.transition_to(:complete)
        get diagnostic_cs_accelerator_certificate_path(:question_1)
      end

      it 'redirects to the programme page' do
        expect(response).to redirect_to '/certificate/cs-accelerator'
      end
    end

    context 'when the user is not enrolled' do
      it 'redirects back to the certificate page' do
        get diagnostic_cs_accelerator_certificate_path(:question_1)
        expect(response).to redirect_to '/cs-accelerator'
      end
    end
  end
end
