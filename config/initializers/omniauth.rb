require 'omniauth-oauth2'

module OmniAuth::Strategies
  class Stem < OmniAuth::Strategies::OAuth2
    option :client_options,
           site: ENV.fetch('STEM_OAUTH_SITE'),
           authorize_url: ENV.fetch('STEM_OAUTH_AUTH_URL'),
           token_url: ENV.fetch('STEM_OAUTH_ACCESS_TOKEN_URL')

    uid { user_info['attributes']['uid'][0] }

    info do
      {
        first_name: user_info['attributes']['firstName'][0],
        last_name: user_info['attributes']['lastName'][0],
        email: user_info['attributes']['mail'][0],
        achiever_contact_no: user_info['attributes']['achieverContactNo'][0]
      }
    end

    def user_info
      response ||= access_token.get('/idp/module.php/oauth2/userinfo.php')
      raven_context(response)
      response.parsed
      Raven::Context.clear!
    end

    def callback_url
      return super if ENV['BYPASS_OAUTH'].present?

      ENV.fetch('STEM_OAUTH_CALLBACK_URL')
    end

    def raven_context(response)
      Raven.tags_context(stem_uid: response.parsed['attributes']['uid'][0], status: response.status)
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
  puts 'Faking OAuth login for review apps'
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:stem] = OmniAuth::AuthHash.new(
    provider: 'stem',
    uid: '24675886-34f0-45be-a3f3-52d4970186ed',
    credentials: {
      expires_at: 1_546_601_180,
      refresh_token: '27266366070255897068',
      token: '14849048797785647933'

    },
    info: {
      achiever_contact_no: '94c52a7c-5001-45e3-82bd-949a882f5fb6',
      first_name: 'Web',
      last_name: 'Raspberry Pi',
      email: 'web@raspberrypi.org'
    }
  )
end
