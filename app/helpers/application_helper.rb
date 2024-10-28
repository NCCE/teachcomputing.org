module ApplicationHelper
  include Pagy::Frontend

  def meta_tag(tag, text)
    content_for :"meta_#{tag}", text
  end

  def yield_meta_tag(tag, default_text = "")
    content_for?(:"meta_#{tag}") ? content_for(:"meta_#{tag}") : default_text
  end

  def create_account_url
    return login_path if Rails.application.config.bypass_oauth

    request_params = {
      registrationUrl: "https://preprod-account.stem.org.uk/registration",
      client_id: Rails.application.config.auth0_client_id,
      screen_hint: "signup",
      scope: "openid profile",
      response_type: "code",
      redirect_uri: "https://preprod-account.stem.org.uk/api/auth/callback",
      state: SecureRandom.hex(10)
    }
    URI::HTTPS.build(host: Rails.application.config.stem_signin_site, path: "/authorize", query: request_params.to_query).to_s
  end

  def auth_url
    "/auth/stem"
  end

  def news_url
    cms_posts_url(tag: :news)
  end

  def press_url
    cms_posts_url(tag: :press)
  end

  def static_asset_url(filename)
    "#{Rails.application.config.static_asset_url}/#{filename}"
  end

  def safe_redirect_url(url)
    allowed_redirect_urls = [
      %r{^https://teachcomputing.rpfdev.com},
      %r{^https://teachcomputing.test},
      %r{^https://teachcomputing.org},
      %r{^https://staging.teachcomputing.org},
      %r{^https://stem.org.uk},
      %r{^https://www.stem.org.uk},
      %r{^https://www-stage.stem.org.uk},
      %r{^https://teachcomputing-staging-pr-([0-9]+).herokuapp.com},
      %r{^https://teachcomputing-pr-([0-9]+).herokuapp.com},
      %r{^https://ncce.io},
      %r{^https://qa.teachcomputing.org}
    ]
    allowed_redirect_urls.push(%r{^http://localhost:3000}) if Rails.env.development?
    allowed_redirect_urls.each do |regex|
      return url if url&.match?(regex)
    end
    nil
  end

  def govuk_padding_classes(padding)
    govuk_spacing_processing(padding, "padding")
  end

  def govuk_margin_classes(margin)
    govuk_spacing_processing(margin, "margin")
  end

  def govuk_spacing_processing(options, type)
    classes = options.except(:all).map { |k, v| "govuk-!-#{type}-#{k}-#{v}" }
    classes << "govuk-!-#{type}-#{options[:all]}" unless options[:all].nil?
    classes
  end
end
