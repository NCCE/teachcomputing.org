class CmsController < ApplicationController
  include CmsProcessing
  layout "full-width"

  def home
    process_resource(Cms::Singles::Homepage)
  end

  def blog
    title = params[:tag] || "News & Updates"
    process_collection Cms::Collections::Blog, title:,
      page_name: "Articles", collection_wrapper: "ncce-news-archive"
  end

  def blog_resource
    process_resource Cms::Collections::Blog, resource_id: params[:page_slug]
  end

  def web_page_resource
    process_resource Cms::Collections::WebPage, resource_id: params[:page_slug]
  end

  def web_page_refresh
    Cms::Collections::WebPage.clear_cache(params[:page_slug])
    Cms::Collections::AsideSection.clear_cache
    redirect_to request.fullpath.sub(%r{/refresh$}, "")
  end

  def clear_blog_cache
    Cms::Collections::Blog.clear_cache(params[:page_slug])
    redirect_to request.fullpath.sub(%r{/refresh$}, "")
  end

  def enrichment
    process_resource Cms::Collections::EnrichmentPage, resource_id: params[:page_slug]
  end

  def enrichment_refresh
    Cms::Collections::EnrichmentPage.clear_cache(params[:page_slug])
    redirect_to request.fullpath.sub(%r{/refresh$}, "")
  end
end
