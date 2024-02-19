module StrapiStubs
  def stub_strapi_get_single_entity(resource_key)
    json_response = File.new("spec/support/cms/providers/strapi/single_type_response.json")
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
    stub_request(:get, /^http:\/\/strapi.teachcomputing.rpfdev.com\/api\/#{resource_key}?/).to_return(body: json_response, status: 404)
  end
end
