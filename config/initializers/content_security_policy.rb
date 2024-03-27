# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy
# For further information see the following documentation
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

Rails.application.config.content_security_policy do |policy|
  ## Production CSPs below are temporarily commented until a workaround for Google Tag Manager can be found
  ## https://github.com/NCCE/teachcomputing.org/pull/1160 (Feb 2021)

  #   policy.default_src :self, :https, 'youtube.com', 'www.youtube.com'
  #   policy.font_src    :self, :https, :data, 'fonts.gstatic.com'
  #   policy.img_src     :self, :https, :data, 'view.vzaar.com', 'blog.teachcomputing.org'
  #   policy.media_src   :self, :https, :data, 'view.vzaar.com', 'download.vzaar.com'
  #   policy.object_src  :none
  #   policy.script_src  :self, :https, :data, 'www.google-analytics.com', 'www.googletagmanager.com', 'tagmanager.google.com'
  #   policy.style_src   :self, :https, :unsafe_inline
  policy.connect_src :self, :https, "https://localhost:3035", "wss://localhost:3035" if Rails.env.development?
end

# If you are using UJS then enable automatic nonce generation
# This overrides 'unsafe-inline', if specified
Rails.application.config.content_security_policy_nonce_generator = ->(request) { SecureRandom.base64(16) }

# For further information see the following documentation:
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy-Report-Only
# Rails.application.config.content_security_policy_report_only = true
