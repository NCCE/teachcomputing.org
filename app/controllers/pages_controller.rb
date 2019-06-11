class PagesController < ApplicationController
  layout 'full-width'
  before_action :redirect_to_dashboard, only: [:login, :signup_stem]

  def page
    render template: "pages/#{params[:page_slug]}"
  end

  def exception
    render template: 'pages/exception', status: params[:status]
  end

  def home
    @featured_posts = Ghost.new.get_featured_posts(ENV['GHOST_LIMIT_FEATURED_POSTS'])
    render template: 'pages/home/index'
  end

  def login
    auth_uri = '/auth/stem'
    if params[:source_uri].present?
      auth_uri += "?source_uri=#{params[:source_uri]}"
    end
    render template: 'pages/login', locals: { auth_uri: auth_uri }
  end

  def signup_stem
    redirect_to "#{ENV.fetch('STEM_OAUTH_SITE')}/user/register?from=NCCE"
  end

  def static_programme_page
    if Programme.find_by!(slug: params[:page_slug]).user_enrolled?(current_user)
      redirect_to programme_path(params[:page_slug])
    else
      render template: "pages/#{params[:page_slug]}"
    end
  end
end
