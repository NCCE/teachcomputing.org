require 'rails_helper'

RSpec.describe AuthController do
  describe '#callback' do
    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:stem] = OmniAuth::AuthHash.new(
        provider: 'stem',
        uid: '2074871c-eb73-4a2f-b9fd-c2fff15f97e7',
        credentials: {
          expires_at: '1546601180',
          refresh_token: '27266366070255897068',
          token: '14849048797785647933'

        },
        info: {
          achiever_contact_no: 'b44cb53f-c690-4535-bd79-89e893337ec6',
          first_name: 'Jane',
          last_name: 'Doe',
          email: 'user@example.com'
        }
      )
    end

    it 'sets the user session' do
      get callback_path

      expect(session['current_user'].id).to eq('2074871c-eb73-4a2f-b9fd-c2fff15f97e7')
    end

    it 'sets updates the user' do
      user = UserDetail.create(stem_user_id: '2074871c-eb73-4a2f-b9fd-c2fff15f97e7', last_sign_in_at: Time.now - 7.days)
      get callback_path
      user.reload

      expect(user.last_sign_in_at.today?).to be_truthy
    end

    context 'when returnTo is present' do
      it 'redirects to the path stated in returnTo' do
        allow_any_instance_of(described_class).to( # rubocop:disable RSpec/AnyInstance
          receive(:omniauth_params)
          .and_return(
            'returnTo' => '/test'
          )
        )
        get callback_path
        expect(response).to redirect_to('/test')
      end
    end

    context 'when returnTo is not present' do
      it 'redirects to the dashboard path' do
        get callback_path
        expect(response).to redirect_to('/')
      end
    end
  end
end