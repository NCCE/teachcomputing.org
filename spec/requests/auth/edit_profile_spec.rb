require 'rails_helper'

RSpec.describe AuthController do
  describe '#logout' do
    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:stem] = OmniAuth::AuthHash.new(
        provider: 'stem',
        uid: '2074871c-eb73-4a2f-b9fd-c2fff15f97e7',
        credentials: {
          expires_at: 1546601180,
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

      get callback_path
    end

    it 'redirects you to the edit_profile path' do
      get edit_profile_path
      expect(response).to redirect_to("#{ENV.fetch('STEM_OAUTH_SITE')}/user/2074871c-eb73-4a2f-b9fd-c2fff15f97e7/edit")
    end
  end
end
