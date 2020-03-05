class CmsController < ApplicationController
  layout 'full-width'

  def cms_page
    @page = Ghost.new.get_single_page(params[:page_slug])
    render :cms_page
  end

  def clear_page_cache
    Ghost.new.clear_page_cache(params[:page_slug])
    return redirect_to cms_page_path(page_slug: params[:page_slug])
  end
end
