class PagesController < ApplicationController
  layout "full-width", only: [:home]
  before_action :redirect_to_dashboard, only: [:login]
  def page
    render template: "pages/#{params[:page_slug]}"
  end

  def exception
    render :exception, status: params[:status]
  end

  def home
    render template: "pages/home/index"
  end

  def login
    render template: "pages/login"
  end
end
