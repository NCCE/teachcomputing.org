require "omniauth-oauth2"
require "omniauth-auth0"

module OmniAuth::Strategies
  class Stem < OmniAuth::Strategies::Auth0
    option :name, "stem"

    info do
      {
        first_name: "given_name",
        last_name: "family_name",
        email: "userEmail",
        achiever_contact_no: "achiever_contact_no",
        achiever_organisation_no: "achiever_organisation_no",
        school_name: "school_name",
        stem_user_id: "integrationkey"
      }.each_with_object({}) do |(key, auth0_key), our_info|
        our_info[key] = raw_info[auth0_key] if raw_info.has_key?(auth0_key)
      end
    end

    def callback_url
      return super if ENV.fetch("BYPASS_OAUTH", false) == "true"

      full_host + script_name + callback_path
    end

    def sentry_context(response)
      Sentry.set_tags(response: response.parsed)
    end
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    OmniAuth::Strategies::Stem,
    ENV.fetch("STEM_OAUTH_CLIENT_ID"),
    ENV.fetch("STEM_OAUTH_CLIENT_SECRET"),
    ENV.fetch("STEM_AUTH0_DOMAIN"),
    callback_path: "/auth/callback",
    authorize_params: {
      scope: "openid profile"
    }
  )
end

# Wrap the code to avoid autoloading classes too early in the runtime, this will cause an error in
# future Rails versions see https://guides.rubyonrails.org/autoloading_and_reloading_constants.html#autoloading-when-the-application-boots
Rails.application.reloader.to_prepare do
  OmniAuth.config.on_failure { |env| AuthController.action(:failure).call(env) }
end

OmniAuth.config.logger = Rails.logger if Rails.env.development?

if ENV.fetch("BYPASS_OAUTH", false) == "true"
  puts "Bypassing OAuth login"
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:stem] = OmniAuth::AuthHash.new(
    provider: "stem",
    uid: "864302",
    credentials: {
      expires_at: 1_546_601_180,
      refresh_token: "27266366070255897068",
      token: "14849048797785647933"
    },
    info: {
      achiever_contact_no: "89085e3f-d60e-eb11-a813-000d3a86f6ce",
      first_name: "Web",
      last_name: "Teach Computing",
      email: "web@teachcomputing.org",
      stem_user_id: "864302"
    }
  )
end
