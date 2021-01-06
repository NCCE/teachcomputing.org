class CmsController < ApplicationController
  layout 'full-width'

  def cms_page
    @page = Ghost.new.get_single_page(params[:page_slug])
    @parent_slug = get_parent_slug
    render :cms_page
  end

  def get_parent_slug
    route = request.env['PATH_INFO'].split('/').reject { |el| el.empty? }
    parent = route[0] || ''
  end

  def clear_page_cache
    Ghost.new.clear_page_cache(params[:page_slug])
    return redirect_to request.fullpath.sub(/\/refresh$/, '')
  end
end
