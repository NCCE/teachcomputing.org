class CmsController < ApplicationController
  layout 'full-width'

  def cms_page
    @page = Ghost.new.get_single_page(params[:page_slug])
    render :cms_page
  end
end
