module ApplicationHelper
  def meta_tag(tag, text)
    content_for :"meta_#{tag}", text
  end

  def yield_meta_tag(tag, default_text = '')
    content_for?(:"meta_#{tag}") ? content_for(:"meta_#{tag}") : default_text
  end

  def create_account_url
    return login_path if ActiveRecord::Type::Boolean.new.cast(ENV['BYPASS_OAUTH'])

    "#{ENV['STEM_OAUTH_SITE']}/user/register?from=NCCE"
  end

  def auth_url
    '/auth/stem'
  end

  def news_url
    'https://blog.teachcomputing.org/tag/news/'
  end

  def press_url
    'https://blog.teachcomputing.org/tag/press/'
  end

  def safe_redirect_url(url)
    allowed_redirect_urls = [
      %r{^https://teachcomputing.rpfdev.com},
      %r{^https://teachcomputing.org},
      %r{^https://staging.teachcomputing.org},
      %r{^https://stem.org.uk},
      %r{^https://www.stem.org.uk},
      %r{^https://www-stage.stem.org.uk},
      %r{^https://teachcomputing-staging-pr-([0-9]+).herokuapp.com},
      %r{^https://ncce.io}
    ]
    allowed_redirect_urls.push(%r{^http://localhost:3000}) if ENV['RAILS_ENV'] == 'development'
    allowed_redirect_urls.each do |regex|
      return url if url =~ regex
    end
    nil
  end
end
