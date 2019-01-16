# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy
# For further information see the following documentation
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

Rails.application.config.content_security_policy do |policy|
  policy.default_src :self, :https
  policy.font_src    :self, :https, :data
  policy.img_src     :self, :https, :data
  policy.object_src  :none
  policy.script_src  :self, :https, 'www.google-analytics.com', 'www.googletagmanager.com'
  policy.style_src   :self, :https

  policy.report_uri 'https://sentry.io/api/1370995/security/?sentry_key=f6ac7f0efe2242db8a1439f5059fafad'
end

# If you are using UJS then enable automatic nonce generation
# This overrides 'unsafe-inline', if specified
Rails.application.config.content_security_policy_nonce_generator = -> request { SecureRandom.base64(16) }

# For further information see the following documentation:
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy-Report-Only
# Rails.application.config.content_security_policy_report_only = true
