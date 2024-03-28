module StrapiStubs
  def stub_strapi_get_single_entity(resource_key)
    json_response = File.new("spec/support/cms/providers/strapi/single_type_response.json")
    stub_request(:get, /^http:\/\/strapi.teachcomputing.rpfdev.com\/api\/#{resource_key}?/).to_return(body: json_response)
  end

  def stub_strapi_get_single_simple_page(resource_key)
    json_response = File.new("spec/support/cms/providers/strapi/simple_page_response.json")
    stub_request(:get, /^http:\/\/strapi.teachcomputing.rpfdev.com\/api\/#{resource_key}?/).to_return(body: json_response)
  end

  def stub_strapi_get_single_entity_with_preview(resource_key)
    json_response = File.new("spec/support/cms/providers/strapi/single_type_response_with_preview.json")
    stub_request(:get, /^http:\/\/strapi.teachcomputing.rpfdev.com\/api\/#{resource_key}?/).to_return(body: json_response)
  end

  def stub_strapi_get_single_blog_post(resource_key)
    json_response = File.new("spec/support/cms/providers/strapi/blog_response.json")
    stub_request(:get, /^http:\/\/strapi.teachcomputing.rpfdev.com\/api\/#{resource_key}?/).to_return(body: json_response)
  end

  def stub_strapi_get_collection_entity(resource_key)
    json_response = File.new("spec/support/cms/providers/strapi/collection_type_response.json")
    stub_request(:get, /^http:\/\/strapi.teachcomputing.rpfdev.com\/api\/#{resource_key}?/).to_return(body: json_response)
  end

  def stub_strapi_not_found(resource_key)
    json_response = File.new("spec/support/cms/providers/strapi/not_found_response.json")
    stub_request(:get, /^http:\/\/strapi.teachcomputing.rpfdev.com\/api\/#{resource_key}*/).to_return(body: json_response, status: 404)
  end

  def stub_strapi_blog_tags
    json_response = File.new("spec/support/cms/providers/strapi/blog_tags.json")
    stub_request(:get, "http://strapi.teachcomputing.rpfdev.com/api/blog-tags").to_return(body: json_response)
  end

  def stub_strapi_media_upload
    json_response = File.new("spec/support/cms/providers/strapi/media_response.json")
    stub_request(:post, /^http:\/\/strapi.teachcomputing.rpfdev.com\/api\/upload/).to_return(body: json_response)
  end

  def stub_strapi_media_query
    json_response = File.new("spec/support/cms/providers/strapi/media_query.json")
    stub_request(:get, /^http:\/\/strapi.teachcomputing.rpfdev.com\/api\/upload\/files/).to_return(body: json_response)
  end

  def stub_strapi_update resource_key
    stub_request(:put, /^http:\/\/strapi.teachcomputing.rpfdev.com\/api\/#{resource_key}/).to_return(body: {}.to_json)
  end

  def stub_strapi_create resource_key
    stub_request(:post, /^http:\/\/strapi.teachcomputing.rpfdev.com\/api\/#{resource_key}/).to_return(body: {}.to_json)
  end

  def stub_featured_posts
    stub_strapi_get_collection_entity("blogs")
  end

  def stub_featured_posts_error
    stub_request(:get, /^http:\/\/strapi.teachcomputing.rpfdev.com\/api\/blogs/)
      .to_return(status: [500, "Internal Server Error"])
  end
end
