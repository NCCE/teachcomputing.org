class PagesController < ApplicationController
  def page
    render template: "pages/#{params[:page_slug]}"
  end

  def exception
    render :exception, status: params[:status]
  end
end
