class CmsController < ApplicationController
  layout 'full-width'

  def cms_page
    @page = Ghost.new.get_single_page(params[:page_slug])
    @parent_slug = parent_slug
    render :cms_page
  end

  def parent_slug
    route = request.env['PATH_INFO'].split('/').reject(&:empty?)
    route[0] || ''
  end

  def clear_page_cache
    Ghost.new.clear_page_cache(params[:page_slug])
    redirect_to request.fullpath.sub(%r{/refresh$}, '')
  end
end
