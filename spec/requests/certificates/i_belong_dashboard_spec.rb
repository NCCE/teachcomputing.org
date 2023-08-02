require 'rails_helper'

RSpec.describe Certificates::IBelongCertificateController do
  let(:user) { create(:user) }
  let(:certificate) { create(:i_belong_certificate) }
  let(:enrolment) { create(:user_programme_enrolment, user: user, programme: certificate) }
 
  describe '#show' do
    before do
      stub_attendance_sets
      stub_delegate
    end

    describe 'while unenrolled' do
      before do
        certificate
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      end

      it 'redirects to I Belong public page' do
        pending 'public page branch not merged yet, so i_belong_path not defined'

        expect {
          get '/certificate/i-belong-certificate'
        }.not_to raise_error(NameError) # TODO: this expectation will be redundant when you expect the redirect

        # TODO:   expect(response).to redirect_to(/i-belong/)
      end
    end

    describe 'while enrolled' do
      before do
        enrolment
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
        get '/certificate/i-belong-certificate'
      end

      it 'renders the correct template' do
        expect(response).to render_template('show')
      end

      it 'asks client not to cache a private page' do
        expect(response.headers['cache-control']).to eq('no-store')
      end

      pending 'spec(s) for displaying achievements in groups'
    end

    describe 'while logged out' do
      before do
        get '/certificate/i-belong-certificate'
      end

      it 'redirects to login' do
        expect(response).to redirect_to(/register/)
      end
    end
  end
end
