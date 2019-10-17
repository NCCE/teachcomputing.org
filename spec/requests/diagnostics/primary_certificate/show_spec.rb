require 'rails_helper'

RSpec.describe Diagnostics::PrimaryCertificateController do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let(:activity) { create(:activity, :primary_certificate_diagnostic_tool) }

  describe 'GET show' do
    before do
      programme
      activity
      programme.activities << activity
    end

    describe 'while logged in' do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      end

      context 'when the user has not completed the diagnostic' do
        it 'renders the first step in the wizard' do
          get primary_certificate_diagnostic_path(:question_1)
          expect(response).to render_template(:question_1)
        end
      end

      context 'when the user has completed the diagnostic' do
        before do
          achievement = create(:achievement, activity_id: activity.id, user_id: user.id)
          achievement.transition_to(:complete)
        end
        
        it 'redirects to the programme page' do
          get primary_certificate_diagnostic_path(:question_1)
          expect(response).to redirect_to '/certificate/primary-certificate'
        end
      end
    end
  end
end
