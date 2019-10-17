require 'rails_helper'

RSpec.describe Diagnostics::PrimaryCertificateController do
  let(:user) { create(:user) }
  let(:programme) { create(:primary_certificate) }
  let(:activity) { create(:activity, :primary_certificate_diagnostic_tool) }

  describe 'PUT update' do
    before do
      programme
      activity
      programme.activities << activity
    end

    describe 'while logged in' do
      before do
        allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
      end

      it 'saves the repsonse in the session' do
        put update_primary_certificate_diagnostic_path(id: :question_1, diagnostic: { question_1: '15' })
        expect(session[:primary_diagnostic]).to eq('question_1' => '15')
      end
    end
  end
end