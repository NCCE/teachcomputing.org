require 'rails_helper'

RSpec.describe Diagnostics::PrimaryCertificateController do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let(:primary_enrolment_questionnaire) { create(:questionnaire, :primary_enrolment_questionnaire) }
  let(:primary_enrolment_unanswered) do
    create(:primary_enrolment_unanswered, questionnaire: primary_enrolment_questionnaire, user: user)
  end
  let(:user_programme_enrolment) { create(:user_programme_enrolment, programme: programme, user: user) }

  describe 'PUT update' do
    context 'when logged in' do
      before do
        primary_enrolment_unanswered
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        user_programme_enrolment
      end

      it 'redirects to the first unanswered question' do
        put update_diagnostic_primary_certificate_path(id: :question_3, diagnostic: { question_3: '10' })
        expect(response).to redirect_to '/certificate/primary-certificate/questionnaire/question_1'
      end

      it 'redirects to the first unanswered question after answering the final question' do
        put update_diagnostic_primary_certificate_path(id: :question_4, diagnostic: { question_4: '20' })
        expect(response).to redirect_to '/certificate/primary-certificate/questionnaire/question_1'
      end

      it 'redirects to the next sequential question after editing an answer' do
        put update_diagnostic_primary_certificate_path(id: :question_1, diagnostic: { question_1: '15' })
        put update_diagnostic_primary_certificate_path(id: :question_2, diagnostic: { question_2: '20' })
        put update_diagnostic_primary_certificate_path(id: :question_1, diagnostic: { question_1: '15' })
        expect(response).to redirect_to '/certificate/primary-certificate/questionnaire/question_2'
      end

      it 'redirects after the final question' do
        put update_diagnostic_primary_certificate_path(id: :question_1, diagnostic: { question_1: '5' })
        put update_diagnostic_primary_certificate_path(id: :question_2, diagnostic: { question_2: '0' })
        put update_diagnostic_primary_certificate_path(id: :question_3, diagnostic: { question_3: '0' })
        put update_diagnostic_primary_certificate_path(id: :question_4, diagnostic: { question_4: '0' })
        expect(response).to redirect_to '/certificate/primary-certificate'
      end
    end
  end
end
