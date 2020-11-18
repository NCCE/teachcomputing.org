require 'rails_helper'

RSpec.describe Certificates::PrimaryCertificateController do
  let(:user) { create(:user) }
  let(:secondary_certificate) { create(:secondary_certificate) }

  describe '#show' do
    context 'when user is logged in' do
      before do
        secondary_certificate
        allow_any_instance_of(AuthenticationHelper)
          .to receive(:current_user).and_return(user)
      end
    end
  end
end
