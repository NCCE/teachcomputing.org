module CmsProcessing
  extend ActiveSupport::Concern

  def process_collection(klass, title:, page_name:, collection_wrapper:, page_size: 50)
    page = process_page
    @title = title
    @page_name = page_name
    @collection_wrapper_class = collection_wrapper
    @path = cms_posts_path
    @collection = klass.all(page, page_size, params: {query: params.permit(klass.query_keys).to_h})
    render "cms/collection"
  end

  def process_resource(klass, resource_id: nil)
    klass.clear_cache if params["refresh"]
    preview = preview_params[:preview] || false
    preview_key = preview_params[:preview_key] || nil


    validate_slug!(resource_id)

    if resource_id
      # Temp fix to handle / routes should not be need if we move to graphql
      raise ActiveRecord::RecordNotFound if resource_id.include?("_")  # Prevent routing to underscored versions
      resource_id.tr!("/", "_") # Convert / to _ so it can be handled strapi side
    end
    @resource = klass.get(resource_id, preview:, preview_key:)
    render "cms/resource"
  end

  def process_page
    [params[:page].to_i, 1].max
  end

  private

  def preview_params
    params.permit(:preview, :preview_key)
  end

  def validate_slug!(slug)
    raise ActiveRecord::RecordNotFound unless slug.match?(/^[a-zA-z0-9\-_\/]+$/)
  end
end
