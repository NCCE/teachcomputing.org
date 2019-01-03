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
