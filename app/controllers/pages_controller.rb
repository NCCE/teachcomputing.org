class PagesController < ApplicationController
  def page
    render template: "pages/#{params[:page_slug]}"
  end
end
