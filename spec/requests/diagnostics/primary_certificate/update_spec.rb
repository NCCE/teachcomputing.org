require 'rails_helper'

RSpec.describe Diagnostics::PrimaryCertificateController do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let(:primary_enrolment_questionnaire) { create(:questionnaire, :primary_enrolment_questionnaire) }
  let(:primary_enrolment_unanswered) { create(:primary_enrolment_unanswered, questionnaire: primary_enrolment_questionnaire, user: user) }
  let(:primary_enrolment_response) {
    QuestionnaireResponse.find_by(questionnaire: primary_enrolment_questionnaire, user: user)
  }
  let(:enrolment) { create(:user_programme_enrolment, programme: programme, user: user) }

  describe 'PUT update' do
    before do
      enrolment
    end

    describe 'while logged in' do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        primary_enrolment_unanswered
      end

      it 'redirects to the first unanswered question (where earlier answers are missing)' do
        put update_primary_certificate_diagnostic_path(id: :question_3, diagnostic: { question_3: '10' })
        expect(response).to redirect_to '/certificate/primary-certificate/questionnaire/question_1'
      end

      it 'does not redirect to the next unanswered question when editing an answer' do
        put update_primary_certificate_diagnostic_path(id: :question_1, diagnostic: { question_1: '15' })
        put update_primary_certificate_diagnostic_path(id: :question_2, diagnostic: { question_2: '20' })
        put update_primary_certificate_diagnostic_path(id: :question_1, diagnostic: { question_1: '15' })
        expect(response).to redirect_to '/certificate/primary-certificate/questionnaire/question_2'
      end

      it 'does not redirect to the next unanswered question when editing an answer' do
        put update_primary_certificate_diagnostic_path(id: :question_4, diagnostic: { question_4: '15' })
        put update_primary_certificate_diagnostic_path(id: :question_2, diagnostic: { question_2: '15' })
        expect(response).to redirect_to '/certificate/primary-certificate/questionnaire/question_1'
      end

      it 'saves the question_1 response correctly' do
        put update_primary_certificate_diagnostic_path(id: :question_1, diagnostic: { question_1: '15' })
        questionnaire_response = primary_enrolment_response
        expect(questionnaire_response.answers['1'].to_i).to eq(15)
        expect(questionnaire_response.current_question).to eq(2)
      end

      it 'saves the question_2 response correctly' do
        put update_primary_certificate_diagnostic_path(id: :question_1, diagnostic: { question_1: '15' })
        put update_primary_certificate_diagnostic_path(id: :question_2, diagnostic: { question_2: '20' })
        questionnaire_response = primary_enrolment_response
        expect(questionnaire_response.answers['2'].to_i).to eq(20)
        expect(questionnaire_response.current_question).to eq(3)
      end

      it 'saves the question_3 response correctly' do
        put update_primary_certificate_diagnostic_path(id: :question_1, diagnostic: { question_1: '15' })
        put update_primary_certificate_diagnostic_path(id: :question_2, diagnostic: { question_2: '20' })
        put update_primary_certificate_diagnostic_path(id: :question_3, diagnostic: { question_3: '10' })
        questionnaire_response = primary_enrolment_response
        expect(questionnaire_response.answers['3'].to_i).to eq(10)
        expect(questionnaire_response.current_question).to eq(4)
      end

      it 'saves the question_4 response correctly' do
        put update_primary_certificate_diagnostic_path(id: :question_1, diagnostic: { question_1: '15' })
        put update_primary_certificate_diagnostic_path(id: :question_2, diagnostic: { question_2: '20' })
        put update_primary_certificate_diagnostic_path(id: :question_3, diagnostic: { question_3: '10' })
        put update_primary_certificate_diagnostic_path(id: :question_4, diagnostic: { question_4: '0' })
        questionnaire_response = primary_enrolment_response
        expect(questionnaire_response.answers['1'].to_i).to eq(15)
        expect(questionnaire_response.answers['2'].to_i).to eq(20)
        expect(questionnaire_response.answers['3'].to_i).to eq(10)
        expect(questionnaire_response.answers['4'].to_i).to eq(0)
        expect(questionnaire_response.current_question).to eq(4)
      end
    end
  end
end
