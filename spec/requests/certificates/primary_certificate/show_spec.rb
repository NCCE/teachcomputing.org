require 'rails_helper'

RSpec.describe Certificates::PrimaryCertificateController do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }

  describe '#show' do
    context 'when user is logged in' do
      context 'when user is not enrolled' do
        it 'redirects if not enrolled' do
          programme
          allow_any_instance_of(AuthenticationHelper)
            .to receive(:current_user).and_return(user)

          get primary_certificate_path
          expect(response).to redirect_to(primary_path)
        end
      end
    end

    describe 'while logged out' do
      it 'redirects to login' do
        get primary_certificate_path
        expect(response).to redirect_to(/register/)
      end
    end
  end
end
