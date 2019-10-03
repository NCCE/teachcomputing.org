class PagesController < ApplicationController
  layout 'full-width'

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

  def static_programme_page
    if Programme.find_by!(slug: params[:page_slug]).user_enrolled?(current_user)
      redirect_to programme_path(params[:page_slug])
    else
      render template: "pages/#{params[:page_slug]}"
    end
  end
end
