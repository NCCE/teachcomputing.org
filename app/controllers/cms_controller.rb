class CmsController < ApplicationController
  include CmsProcessing
  layout "full-width"

  def blog
    process_collection Cms::Collections::Blog, title: "News & Updates",
      page_name: "Articles", collection_wrapper: "ncce-news-archive"
  end

  def blog_resource
    process_resource Cms::Collections::Blog, resource_id: params[:page_slug]
  end

  def page_resource
    process_resource Cms::Collections::SimplePage, resource_id: params[:page_slug]
  end

  def style_slug
    params[:parent_slug] || params[:page_slug]
  end

  def clear_page_cache
    Cms::Collections::Blog.clear_cache(build_slug_from_params)
    redirect_to request.fullpath.sub(%r{/refresh$}, "")
  end

  private

  def build_slug_from_params
    return params[:page_slug] if params[:parent_slug].blank?

    "#{params[:parent_slug]}-#{params[:page_slug]}"
  end
end
