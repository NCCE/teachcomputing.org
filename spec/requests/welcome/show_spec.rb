require 'rails_helper'

RSpec.describe WelcomeController do
  let(:user) { create(:user) }
  let(:cs_accelerator) { create(:cs_accelerator) }
  let(:primary_certificate) { create(:primary_certificate) }

  let(:cs_accelerator_enrolment) do
    create(:user_programme_enrolment,
           user_id: user.id,
           programme_id: cs_accelerator.id)
  end

  let(:primary_certificate_enrolment) do
    create(:user_programme_enrolment,
           user_id: user.id,
           programme_id: primary_certificate.id)
  end

  describe '#show' do
    context 'when the user is logged out' do
      before do
        get welcome_path
      end

      it 'redirects to login' do
        expect(response).to redirect_to(/register/)
      end
    end

    context 'when the user is logged in' do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        cs_accelerator
        primary_certificate
        get welcome_path
      end

      it 'renders the correct template' do
        expect(response).to render_template('show')
      end
    end

    context 'when the user is logged in and enrolled on cs_accelerator' do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        primary_certificate_enrolment
        cs_accelerator_enrolment
        user.reload
        get welcome_path
      end

      it 'redirects to the correct programme page' do
        expect(response).to redirect_to(/\/certificate\/cs-accelerator/)
      end
    end

    context 'when the user is logged in and enrolled on cs_accelerator' do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        cs_accelerator
        primary_certificate_enrolment
        user.reload
        get welcome_path
      end

      it 'redirects to the correct programme page' do
        expect(response).to redirect_to(/\/certificate\/primary-certificate/)
      end
    end
  end
end
