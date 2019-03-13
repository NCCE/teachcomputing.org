require 'rails_helper'

RSpec.describe AuthController do
  describe '#callback' do
    let(:user) { create(:user, stem_user_id: '2074871c-eb73-4a2f-b9fd-c2fff15f97e7') }

    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:stem] = OmniAuth::AuthHash.new(
        provider: 'stem',
        uid: '2074871c-eb73-4a2f-b9fd-c2fff15f97e7',
        credentials: {
          expires_at: 1_546_601_180,
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
      user
      get callback_path

      expect(session['user_id']).to eq(user.id)
    end

    context 'when source_uri is present' do
      before do
        OmniAuth.config.test_mode = true
        OmniAuth.config.mock_auth[:stem] = OmniAuth::AuthHash.new(
          source_uri: '/test',
          provider: 'stem',
          uid: '2074871c-eb73-4a2f-b9fd-c2fff15f97e7',
          credentials: {
            expires_at: 1_546_601_180,
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
        # AuthController.any_instance.stub(:session).and_return({ 'omniauth.params' => { source_uri: '/test'}})
      end

      it 'redirects to the path stated in source_uri' do
        # get callback_path, nil, { 'omniauth.params' => { source_uri: '/test'}}
        byebug
        get callback_path

        expect(response).to redirect_to('/test?firstLogin=true')
      end
    end

    context 'when source_uri is not present' do
      before do
        OmniAuth.config.test_mode = true
        OmniAuth.config.mock_auth[:stem] = OmniAuth::AuthHash.new(
          provider: 'stem',
          uid: '2074871c-eb73-4a2f-b9fd-c2fff15f97e7',
          credentials: {
            expires_at: 1_546_601_180,
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

      it 'redirects to the dashboard path' do
        get callback_path
        expect(response).to redirect_to('/dashboard?firstLogin=true')
      end
    end
  end
end
