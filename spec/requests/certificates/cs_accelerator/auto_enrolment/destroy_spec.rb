require 'rails_helper'

RSpec.describe Certificates::CSAccelerator::AutoEnrolmentsController do
  let(:user) { create(:user) }
  let(:programme) { create(:cs_accelerator) }

  describe 'GET #destroy' do
    subject(:unenroll) { get unenroll__cs_accelerator_auto_enrolment_path }

    before do
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    end

    context 'when user is enrolled on cs_accelerator' do
      let!(:enrolment) { create(:user_programme_enrolment, user: user, programme: programme) }

      it 'redirects to the dashboard path' do
        unenroll
        expect(response).to redirect_to(dashboard_path)
      end

      it 'sets the users enrolment to :unenrolled' do
        user_enrolment = user.user_programme_enrolments.find_by(programme: programme)

        expect { unenroll }
          .to change { user_enrolment.current_state }
          .from('enrolled')
          .to('unenrolled')
      end

      it 'shows a flash notice' do
        unenroll
        expect(flash[:notice]).to be_present
      end

      it 'flash notice has correct info' do
        unenroll
        expect(flash[:notice]).to match(/You have successfully opted out of the Computer Science Accelerator/)
      end
    end

    context 'when user is not enrolled' do
      it 'redirects to dashboard' do
        unenroll
        expect(response).to redirect_to(dashboard_path)
      end

      it 'does not show flash message' do
        unenroll
        expect(flash[:notice]).not_to be_present
      end
    end
  end
end
