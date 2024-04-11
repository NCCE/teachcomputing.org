module CmsProcessing
  extend ActiveSupport::Concern

  def process_collection(klass, title:, page_name:, collection_wrapper:, page_size: 50)
    page = process_page
    @title = title
    @page_name = page_name
    @collection_wrapper_class = collection_wrapper
    @path = cms_posts_path
    @collection = klass.all(page, page_size)
    render :collection
  end

  def process_resource(klass, resource_id: nil)
    klass.clear_cache if params[:refresh_cache]
    preview = preview_params[:preview] || false
    preview_key = preview_params[:preview_key] || nil
    @resource = klass.get(resource_id, preview:, preview_key:)
    render :resource
  end

  def process_page
    page = [params[:page].to_i, 1].max
  end
end
