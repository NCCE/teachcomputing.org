module StrapiStubs
  def stub_strapi_get_single_entity(resource_key)
    json_response = File.new("spec/support/cms/providers/strapi/single_type_response.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}?/).to_return(body: json_response)
  end

  def stub_strapi_get_single_simple_page(resource_key)
    json_response = File.new("spec/support/cms/providers/strapi/simple_page_response.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}?/).to_return(body: json_response)
  end

  def stub_strapi_get_single_web_page(resource_key)
    json_response = File.new("spec/support/cms/providers/strapi/web_page_response.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}?/).to_return(body: json_response)
  end

  def stub_strapi_get_single_entity_with_preview(resource_key)
    json_response = File.new("spec/support/cms/providers/strapi/single_type_response_with_preview.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}?/).to_return(body: json_response)
  end

  def stub_strapi_get_single_blog_post(resource_key)
    json_response = File.new("spec/support/cms/providers/strapi/blog_response.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}?/).to_return(body: json_response)
  end

  def stub_strapi_get_single_unpublished_blog_post(resource_key)
    json_response = File.new("spec/support/cms/providers/strapi/blog_unpublished_response.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}?/).to_return(body: json_response)
  end

  def stub_strapi_get_collection_entity(resource_key)
    json_response = File.new("spec/support/cms/providers/strapi/collection_type_response.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}?/).to_return(body: json_response)
  end

  def stub_strapi_get_empty_collection_entity(resource_key)
    json_response = File.new("spec/support/cms/providers/strapi/empty_collection_type_response.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}?/).to_return(body: json_response)
  end

  def stub_strapi_not_found(resource_key)
    json_response = File.new("spec/support/cms/providers/strapi/not_found_response.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}*/).to_return(body: json_response, status: 404)
  end

  def stub_strapi_blog_tags
    json_response = File.new("spec/support/cms/providers/strapi/blog_tags.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/blog-tags/).to_return(body: json_response)
  end

  def stub_strapi_media_upload
    json_response = File.new("spec/support/cms/providers/strapi/media_response.json")
    stub_request(:post, /^https:\/\/strapi.teachcomputing.org\/api\/upload/).to_return(body: json_response)
  end

  def stub_strapi_media_query
    json_response = File.new("spec/support/cms/providers/strapi/media_query.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/upload\/files/).to_return(body: json_response)
  end

  def stub_strapi_update(resource_key)
    stub_request(:put, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}/).to_return(body: {}.to_json)
  end

  def stub_strapi_create(resource_key)
    stub_request(:post, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}/).to_return(body: {}.to_json)
  end

  def stub_featured_posts
    stub_strapi_blog_collection
  end

  def stub_featured_posts_error
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/blogs/)
      .to_return(status: [500, "Internal Server Error"])
  end

  def stub_strapi_simple_page_collection
    json_response = File.new("spec/support/cms/providers/strapi/simple_pages_collection_response.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/simple-pages/).to_return(body: json_response)
  end

  def stub_strapi_blog_collection
    json_response = File.new("spec/support/cms/providers/strapi/blogs_collection_response.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/blogs/).to_return(body: json_response)
  end

  def stub_strapi_blog_collection_with_tag(tag)
    json_response = File.new("spec/support/cms/providers/strapi/blogs_collection_response.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/blogs\?.*(filters\[blog_tags\]\[slug\]\[\$eq\]=#{tag}).*/).to_return(body: json_response)
  end

  def stub_strapi_aside_section(key)
    json_response = File.new("spec/support/cms/providers/strapi/aside_section_response.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/aside-sections\/#{key}/).to_return(body: json_response)
  end

  def stub_strapi_aside_section_missing(key)
    json_response = File.new("spec/support/cms/providers/strapi/aside_section_response.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/aside-sections\/#{key}/).to_return(body: json_response, status: 404)
  end

  def stub_strapi_enrichment_page(key)
    json_response = File.new("spec/support/cms/providers/strapi/enrichment_page_response.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/enrichment-pages\/#{key}/).to_return(body: json_response)
  end
end
