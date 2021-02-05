require 'rails_helper'

RSpec.describe Diagnostics::CSAcceleratorController do
  let(:user) { create(:user) }
  let!(:programme) { create(:cs_accelerator) }
  let(:cs_accelerator_enrolment_unanswered) do
    create(:cs_accelerator_enrolment_unanswered, programme: programme)
  end
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user: user, programme: programme) }

  describe 'GET update' do
    before do
      cs_accelerator_enrolment_unanswered
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      user_programme_enrolment
    end

    context 'when a user has answered 1 to the first question' do
      before do
        put update_diagnostic_cs_accelerator_certificate_path(id: :question_1, diagnostic: { question_1: '1' })
      end

      it 'marks their diagnostic as complete' do
        qr = QuestionnaireResponse.find_by(user_id: user.id)
        expect(qr.current_state).to eq(:complete.to_s)
      end

      it 'redirects to the programme page' do
        expect(response).to redirect_to '/certificate/cs-accelerator'
      end
    end

    it 'redirects to the first unanswered question after answering the final question' do
      put update_diagnostic_cs_accelerator_certificate_path(id: :question_4, diagnostic: { question_4: '20' })
      expect(response).to redirect_to '/certificate/cs-accelerator/questionnaire/question_1'
    end

    # Further coverage provided by primary_certificate update spec
  end
end
