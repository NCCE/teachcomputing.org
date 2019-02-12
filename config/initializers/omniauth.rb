require 'omniauth-oauth2'

module OmniAuth::Strategies
  class Stem < OmniAuth::Strategies::OAuth2
    option :client_options,
           site: ENV.fetch('STEM_OAUTH_SITE'),
           authorize_url: ENV.fetch('STEM_OAUTH_AUTH_URL'),
           token_url: ENV.fetch('STEM_OAUTH_ACCESS_TOKEN_URL')

    uid { raw_info['attributes']['uid'][0] }

    info do
      {
        first_name: raw_info['attributes']['firstName'][0],
        last_name: raw_info['attributes']['lastName'][0],
        email: raw_info['attributes']['mail'][0],
        achiever_contact_no: raw_info['attributes']['achieverContactNo'][0]
      }
    end

    def raw_info
      @raw_info ||= access_token.get('/idp/module.php/oauth2/userinfo.php').parsed
    end

    def callback_url
      ENV.fetch('STEM_OAUTH_CALLBACK_URL')
    end
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    OmniAuth::Strategies::Stem, ENV.fetch('STEM_OAUTH_CLIENT_ID'), ENV.fetch('STEM_OAUTH_CLIENT_SECRET'),
    callback_path: '/auth/callback'
  )
end

OmniAuth.config.on_failure = AuthController.action(:failure)

if ENV['BYPASS_OAUTH'].present?
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:stem] = OmniAuth::AuthHash.new(
    provider: 'stem',
    uid: '791f3d63-21e5-48a5-b4b2-dbf3838f320e',
    credentials: {
      expires_at: 1_546_601_180,
      refresh_token: '27266366070255897068',
      token: '14849048797785647933'

    },
    info: {
      achiever_contact_no: '5676d7e5-cece-4a3d-95e2-884f38c82f57',
      first_name: 'Test',
      last_name: 'User',
      email: 'test-user@example.com'
    }
  )
end