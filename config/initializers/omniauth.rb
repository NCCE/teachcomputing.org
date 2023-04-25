require 'omniauth-oauth2'

module OmniAuth::Strategies
  class Stem < OmniAuth::Strategies::OAuth2
    option :client_options,
           site: ENV.fetch('STEM_OAUTH_SITE'),
           authorize_url: ENV.fetch('STEM_OAUTH_AUTH_URL'),
           token_url: ENV.fetch('STEM_OAUTH_ACCESS_TOKEN_URL')

    uid { user_info['attributes']['uid'][0] }

    info do
      our_info = {}

      {
        first_name: 'firstName',
        last_name: 'lastName',
        email: 'mail',
        achiever_contact_no: 'achieverContactNo',
        achiever_organisation_no: 'achieverOrganisationNo'
      }.each_pair do |key, stem_key|
        our_info[key] = user_info['attributes'][stem_key][0] if user_info['attributes'].has_key?(stem_key)
      end
      our_info
    end

    def user_info
      response ||= access_token.get('/idp/module.php/oauth2/userinfo.php')
      sentry_context(response)
      response.parsed
    end

    def callback_url
      return super if ActiveRecord::Type::Boolean.new.cast(ENV['BYPASS_OAUTH'])

      full_host + script_name + callback_path
    end

    def sentry_context(response)
      Sentry.set_tags(response: response.parsed)
    end
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    OmniAuth::Strategies::Stem, ENV.fetch('STEM_OAUTH_CLIENT_ID'), ENV.fetch('STEM_OAUTH_CLIENT_SECRET'),
    callback_path: '/auth/callback'
  )
end

# Wrap the code to avoid autoloading classes too early in the runtime, this will cause an error in
# future Rails versions see https://guides.rubyonrails.org/autoloading_and_reloading_constants.html#autoloading-when-the-application-boots
Rails.application.reloader.to_prepare do
  OmniAuth.config.on_failure { |env| AuthController.action(:failure).call(env) }
end

OmniAuth.config.logger = Rails.logger if Rails.env.development?

if ActiveModel::Type::Boolean.new.cast(ENV.fetch('BYPASS_OAUTH', false))
  puts 'Bypassing OAuth login'
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:stem] = OmniAuth::AuthHash.new(
    provider: 'stem',
    uid: '864302',
    credentials: {
      expires_at: 1_546_601_180,
      refresh_token: '27266366070255897068',
      token: '14849048797785647933'
    },
    info: {
      achiever_contact_no: '89085e3f-d60e-eb11-a813-000d3a86f6ce',
      first_name: 'Web',
      last_name: 'Teach Computing',
      email: 'web@teachcomputing.org'
    }
  )
end
