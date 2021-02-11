require 'rails_helper'

RSpec.describe Diagnostics::CSAcceleratorController do
  let(:user) { create(:user) }
  let!(:programme) { create(:cs_accelerator) }
  let(:cs_accelerator_enrolment_questionnaire) { create(:questionnaire, :cs_accelerator_enrolment_questionnaire) }
  let(:cs_accelerator_enrolment_unanswered) do
    create(
      :cs_accelerator_enrolment_unanswered,
      questionnaire: cs_accelerator_enrolment_questionnaire,
      programme: programme
    )
  end
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user: user, programme: programme) }
  let!(:new_to_computing_pathway) { create(:pathway, slug: 'new_to_computing') }
  let!(:preparing_to_teach_pathway) { create(:pathway, slug: 'preparing_to_teach') }

  describe 'GET update' do
    before do
      cs_accelerator_enrolment_unanswered
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      user_programme_enrolment
    end

    context 'when a user has answered 1 to the first question' do
      before do
        put update_diagnostic_cs_accelerator_certificate_path(id: :question_1, diagnostic: { question_1: '1' })
        user_programme_enrolment.reload
      end

      it 'stores the result' do
        qr = QuestionnaireResponse.find_by(user_id: user.id)
        expect(qr.answers).to include_json('1': '1')
      end

      it 'marks their diagnostic as complete' do
        qr = QuestionnaireResponse.find_by(user_id: user.id)
        expect(qr.current_state).to eq(:complete.to_s)
      end

      it 'sets the pathway' do
        expect(Pathway.find(user_programme_enrolment.pathway_id).slug).to(eq(new_to_computing_pathway.slug))
      end

      it 'redirects to the programme page' do
        expect(response).to redirect_to '/certificate/cs-accelerator'
      end
    end

    it 'redirects to the first unanswered question after answering the final question' do
      put update_diagnostic_cs_accelerator_certificate_path(id: :question_4, diagnostic: { question_4: '20' })
      expect(response).to redirect_to '/certificate/cs-accelerator/questionnaire/question_1'
    end

    it 'redirects to the next sequential question after editing an answer' do
      put update_diagnostic_cs_accelerator_certificate_path(id: :question_1, diagnostic: { question_1: '3' })
      put update_diagnostic_cs_accelerator_certificate_path(id: :question_2, diagnostic: { question_2: '2' })
      put update_diagnostic_cs_accelerator_certificate_path(id: :question_1, diagnostic: { question_1: '4' })
      expect(response).to redirect_to '/certificate/cs-accelerator/questionnaire/question_2'
    end

    it 'redirects after the final question' do
      put update_diagnostic_cs_accelerator_certificate_path(id: :question_1, diagnostic: { question_1: '2' })
      put update_diagnostic_cs_accelerator_certificate_path(id: :question_2, diagnostic: { question_2: '4' })
      put update_diagnostic_cs_accelerator_certificate_path(id: :question_3, diagnostic: { question_3: '4' })
      put update_diagnostic_cs_accelerator_certificate_path(id: :question_4, diagnostic: { question_4: '4' })
      put update_diagnostic_cs_accelerator_certificate_path(id: :question_5, diagnostic: { question_5: '4' })
      user_programme_enrolment.reload
      expect(response).to redirect_to '/certificate/cs-accelerator'
    end

    # Further coverage provided by primary_certificate update spec
  end
end
