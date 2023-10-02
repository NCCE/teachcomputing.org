require 'rails_helper'

RSpec.describe Certificates::SecondaryCertificateController do
  let(:user) { create(:user) }
  let(:secondary_certificate) { create(:secondary_certificate) }
  let(:secondary_enrolment) { create(:user_programme_enrolment, programme_id: secondary_certificate.id, user_id: user.id) }
  let(:complete_achievements) { user.achievements.without_category('action').belongs_to_programme(secondary_certificate).sort_complete_first }

  describe '#pending' do
    context 'when user is logged in' do
      before do
        secondary_certificate
        allow_any_instance_of(AuthenticationHelper)
          .to receive(:current_user).and_return(user)
      end

      context 'when user is enrolled and that enrolment is in a pending state' do
        before do
          secondary_enrolment.transition_to(:pending)
          get pending_secondary_certificate_path
        end

        it 'renders the pending template' do
          expect(response).to render_template('pending')
        end

        it 'assigns programme' do
          expect(assigns(:programme)).to eq(secondary_certificate)
        end

        it 'assigns complete achievements' do
          expect(assigns(:complete_achievements)).to eq(complete_achievements)
        end
      end

      context 'when the enrolment is not in a pending state' do
        before do
          get pending_secondary_certificate_path
        end

        it 'redirects to login' do
          expect(response).to redirect_to(secondary_path)
        end
      end
    end

    describe 'while logged out' do
      before do
        get pending_secondary_certificate_path
      end

      it 'redirects to login' do
        expect(response).to redirect_to(/register/)
      end
    end
  end
end
