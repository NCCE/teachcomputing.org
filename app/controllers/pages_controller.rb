class PagesController < ApplicationController
  layout 'full-width'
  before_action :redirect_to_dashboard, only: [:login]

  def page
    render template: "pages/#{params[:page_slug]}"
  end

  def exception
    respond_to do |format|
      format.html { render template: 'pages/exception', status: params[:status] }
      format.all { render plain: params[:status], status: params[:status] }
    end
  end

  def home
    posts = Ghost.new.get_featured_posts(5)
    @main_feature, *@featured_posts = posts
    render template: 'pages/home/index'
  end

  def login
    auth_uri = '/auth/stem'
    auth_uri += "?source_uri=#{params[:source_uri]}" if params[:source_uri].present?
    render template: 'pages/login', locals: { auth_uri: auth_uri }
  end

  def static_programme_page
    @download = Download.new
    @programme = Programme.find_by!(slug: params[:page_slug])
    redirect_to @programme.path and return if @programme.user_enrolled?(current_user)

    render template: "pages/enrolment/#{params[:page_slug]}"
  end
end
