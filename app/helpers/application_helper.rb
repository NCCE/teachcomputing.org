module ApplicationHelper
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
end
