class CmsController < ApplicationController
  layout "full-width"

  def articles
    page =
      if params[:page].present?
        params[:page].to_i
      else
        1
      end

    @articles_data = Ghost.new.get_posts(page:, tag: params[:tag])
    @style_slug = style_slug
  end

  def cms_post
    @article = Ghost.new.get_single_post(build_slug_from_params)
    @style_slug = style_slug
    @article_type = :post
    render :article
  end

  def cms_page
    @article = Ghost.new.get_single_page(build_slug_from_params)
    @style_slug = style_slug
    @article_type = :page
    render :article
  end

  def cms_new_page
    @resource = params[:page].get
    render :resource
  end

  def collection
    page =
      if params[:page].present?
        params[:page].to_i
      else
        1
      end
    @collection = params[:collection].all(page, 25)
    render :collection
  end

  def collection_resource
    @resource = params[:collection].get(params: {resource_id: params[:page_slug]})
    render :resource
  end

  def style_slug
    params[:parent_slug] || params[:page_slug]
  end

  def clear_page_cache
    Ghost.new.clear_page_cache(build_slug_from_params)
    redirect_to request.fullpath.sub(%r{/refresh$}, "")
  end

  private

  def build_slug_from_params
    return params[:page_slug] if params[:parent_slug].blank?

    "#{params[:parent_slug]}-#{params[:page_slug]}"
  end
end
