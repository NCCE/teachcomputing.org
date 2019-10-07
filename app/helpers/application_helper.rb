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
end
