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
    process_resource Cms::Collections::Blog, params: {resource_id: params[:page_slug]}
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

  def process_collection(cls, title: "News & Updaets", page_name: "Atricles", collection_wrapper: "ncce-news-archive")
    page =
      if params[:page].present?
        params[:page].to_i
      else
        1
      end
    @title = title
    @page_name = page_name
    @collection_wrapper_class = collection_wrapper
    @collection = cls.all(page, 25)
    render :collection
  end

  def process_resource cls, params: {}
    @resource = cls.get(params:)
    render :resource
  end

  def build_slug_from_params
    return params[:page_slug] if params[:parent_slug].blank?

    "#{params[:parent_slug]}-#{params[:page_slug]}"
  end

end
