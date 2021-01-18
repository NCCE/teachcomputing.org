class CmsController < ApplicationController
  layout 'full-width'

  def cms_page
    @page = Ghost.new.get_single_page(build_slug_from_params)
    @style_slug = style_slug
    render :cms_page
  end

  def style_slug
    params[:parent_slug] || params[:page_slug]
  end

  def clear_page_cache
    Ghost.new.clear_page_cache(build_slug_from_params)
    redirect_to request.fullpath.sub(%r{/refresh$}, '')
  end

  private

    def build_slug_from_params
      return params[:page_slug] unless params[:parent_slug].present?

      "#{params[:parent_slug]}-#{params[:page_slug]}"
    end
end
