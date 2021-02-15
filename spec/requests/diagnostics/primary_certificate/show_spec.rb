require 'rails_helper'

RSpec.describe Diagnostics::PrimaryCertificateController do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let(:primary_questionnaire) { create(:questionnaire, :primary_enrolment_questionnaire, programme: programme) }
  let(:user_programme_enrolment) { create(:user_programme_enrolment, user: user, programme: programme) }

  describe 'GET show' do
    before do
      programme
      primary_questionnaire
    end

    describe 'while logged in' do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      end

      context 'when the user has not completed the diagnostic' do
        before do
          user_programme_enrolment
          get diagnostic_primary_certificate_path(:question_1)
        end

        it 'renders a question' do
          expect(response).to render_template(:questions)
        end

        it 'renders the first question' do
          expect(response.body).to include('Question 1 of 4')
        end
      end

      context 'when the user has completed the diagnostic' do
        before do
          user_programme_enrolment
          answers = create(
            :primary_enrolment_score_15, questionnaire: primary_questionnaire,  user: user
          )
          answers.transition_to(:complete)
        end

        it 'redirects to the programme page' do
          get diagnostic_primary_certificate_path(:question_1)
          expect(response).to redirect_to '/certificate/primary-certificate'
        end
      end

      context 'when the user is not enrolled' do
        it 'redirects back to the certificate page' do
          get diagnostic_primary_certificate_path(:question_1)
          expect(response).to redirect_to '/primary-certificate'
        end
      end
    end
  end
end
