module ApplicationHelper
  def meta_tag(tag, text)
    content_for :"meta_#{tag}", text
  end

  def yield_meta_tag(tag, default_text='')
    content_for?(:"meta_#{tag}") ? content_for(:"meta_#{tag}") : default_text
  end

  def create_account_url
    return login_path if ActiveRecord::Type::Boolean.new.cast(ENV['BYPASS_OAUTH'])

    "#{ENV.fetch('STEM_OAUTH_SITE')}/user/register?from=NCCE"
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

  def whitelist_redirect_url(url)
    allowed_redirect_urls = [
      /^https:\/\/teachcomputing.org/,
      /^https:\/\/staging-teachcomputing.org/,
      /^https:\/\/stem.org.uk/,
      /^https:\/\/www.stem.org.uk/,
      /^https:\/\/www-stage.stem.org.uk/,
      /^https:\/\/teachcomputing-staging-pr-([0-9]+).herokuapp.com/,
      /^https:\/\/ncce.io/
    ]
    allowed_redirect_urls.push(/^http:\/\/localhost:3000/) if ENV['RAILS_ENV'] == 'development'
    allowed_redirect_urls.each do |regex|
      return url if url =~ regex
    end
    return nil
  end
end
