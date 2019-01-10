require 'rails_helper'

RSpec.describe AuthController do
  describe '#failure' do
    before do
      OmniAuth.config.test_mode = true
    end

    context 'when an error is encountered' do
      before do
        OmniAuth.config.mock_auth[:stem] = :not_known
      end

      it 'redirects to the root_path' do
        get callback_path
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
