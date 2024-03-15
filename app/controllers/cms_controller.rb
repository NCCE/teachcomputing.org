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

  def blog
    process_collection Cms::Collections::Blog
  end

  def blog_resource
    process_resource Cms::Collections::Blog, resource_params: {resource_id: params[:page_slug]}
  end

  def page_resource
    process_resource Cms::Collections::SimplePage, resource_params: {resource_id: params[:page_slug]}
  end

  def style_slug
    params[:parent_slug] || params[:page_slug]
  end

  def clear_page_cache
    Ghost.new.clear_page_cache(build_slug_from_params)
    redirect_to request.fullpath.sub(%r{/refresh$}, "")
  end

  def privacy
    process_resource Cms::Pages::PrivacyNotice
  end

  def deep_test
    process_resource Cms::Pages::DeepTest
  end

  private

  def process_collection(cls, title: "News & Updates", page_name: "Articles", collection_wrapper: "ncce-news-archive")
    page =
      if params[:page].present?
        params[:page].to_i
      else
        1
      end
    @title = title
    @page_name = page_name
    @collection_wrapper_class = collection_wrapper
    @path = cms_posts_path
    @collection = cls.all(page, 50)
    render :collection
  end

  def process_resource(cls, resource_params: {})
    if params[:refresh_cache]
      cls.clear_cache
    end
    cleaned_params = preview_params
    preview = cleaned_params[:preview] || false
    preview_key = cleaned_params[:preview_key] || nil
    @resource = cls.get(params: resource_params, preview:, preview_key:)
    render :resource
  end

  def build_slug_from_params
    return params[:page_slug] if params[:parent_slug].blank?

    "#{params[:parent_slug]}-#{params[:page_slug]}"
  end

  private

  def preview_params
    params.permit(:preview, :preview_key)
  end
end
