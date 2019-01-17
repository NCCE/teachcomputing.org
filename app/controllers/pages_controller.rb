class PagesController < ApplicationController
  def page
    render template: "pages/#{params[:page_slug]}"
  end

  def home
    render template: "pages/home/index"
  end
end
