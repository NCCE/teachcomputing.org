module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def create_account_url
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
      /^https:\/\/teachcomputing-staging-pr-([0-9]+).herokuapp.com/
    ]
    allowed_redirect_urls.push(/^http:\/\/localhost:3000/) if ENV['RAILS_ENV'] == 'development'
    allowed_redirect_urls.each do |regex|
      return url if url =~ regex
    end
    return nil
  end
end
