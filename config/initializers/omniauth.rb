require 'omniauth-oauth2'

module OmniAuth::Strategies
  class Stem < OmniAuth::Strategies::OAuth2
    option :client_options,
           site: ENV.fetch('STEM_OMNIAUTH_SITE'),
           authorize_url: ENV.fetch('STEM_OMNIAUTH_AUTH_URL'),
           token_url: ENV.fetch('STEM_OMNIAUTH_ACCESS_TOKEN_URL'),
           connection_opts: { proxy: ENV['PROXY_URL'] ? URI(ENV['PROXY_URL']) : nil }

    uid { raw_info['id'] }

    info do
      {
        first_name: raw_info['first_name'],
        last_name: raw_info['last_name'],
        email: raw_info['email']
      }
    end

    extra do
      {
        'raw_info' => raw_info
      }
    end

    # def raw_info
    #   @raw_info ||= access_token.params['code']
    # end
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    OmniAuth::Strategies::Stem, ENV.fetch('STEM_OMNIAUTH_CLIENT_ID'), ENV.fetch('STEM_OMNIAUTH_CLIENT_SECRET'),
    callback_path: '/auth/callback',
    client_options: {
      site: 'https://www-stage.stem.org.uk',
      authorize_url: "#{ENV.fetch('STEM_OMNIAUTH_AUTH_URL')}",
      token_url: "#{ENV.fetch('STEM_OMNIAUTH_ACCESS_TOKEN_URL')}",
      connection_opts: { proxy: ENV['PROXY_URL'] ? URI(ENV['PROXY_URL']) : nil }
    }
  )
end
