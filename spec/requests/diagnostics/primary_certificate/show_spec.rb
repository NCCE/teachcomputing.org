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
        get primary_certificate_diagnostic_path(:introduction)
      end

      it 'renders the first step in the wizard' do
        expect(response).to render_template(:introduction)
      end
    end
  end
end
