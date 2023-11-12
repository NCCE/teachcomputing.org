class CmsController < ApplicationController
  layout 'full-width'

  def articles
    page =
      if params[:page].present?
        params[:page].to_i
      else
        1
      end

    @posts_data = Ghost.new.get_posts(page:, tag: params[:tag])
    @style_slug = style_slug
  end

  def cms_post
    @page = Ghost.new.get_single_post(build_slug_from_params)
    @style_slug = style_slug
    render :cms_page
  end

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
