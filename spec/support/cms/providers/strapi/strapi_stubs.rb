module StrapiStubs
  def stub_strapi_get_single_entity(resource_key)
    json_response = File.new("spec/support/cms/providers/strapi/single_type_response.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}?/).to_return(body: json_response)
  end

  def stub_strapi_get_single_simple_page(resource_key)
    json_response = File.new("spec/support/cms/providers/strapi/simple_page_response.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}?/).to_return(body: json_response)
  end

  def stub_strapi_get_single_entity_with_preview(resource_key)
    json_response = File.new("spec/support/cms/providers/strapi/single_type_response_with_preview.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}?/).to_return(body: json_response)
  end

  def stub_strapi_get_single_blog_post(resource_key, id: nil, title: nil, seo: {})
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}?/).to_return_json(body: {
      data: Cms::Mocks::Blog.generate_raw_data(slug: resource_key, publish_date: Faker::Date.backward.to_s, id:, title:, seo:)
    })
  end

  def stub_strapi_get_single_unpublished_blog_post(resource_key)
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}?/).to_return_json(body: {
      data: Cms::Mocks::Blog.generate_raw_data(slug: resource_key, publish_date: nil, published_at: nil)
    })
  end

  def stub_strapi_get_collection_entity(resource_key)
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}?/).to_return_json(body: to_strapi_collection(
      Array.new(5) { Cms::Mocks::BlogTag.generate_raw_data }
    ))
  end

  def stub_strapi_get_empty_collection_entity(resource_key)
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}?/).to_return_json(body: empty_collection_response)
  end

  def stub_strapi_not_found(resource_key)
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}*/).to_return_json(body: not_found_response, status: 404)
  end

  def stub_strapi_blog_tags
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/blog-tags/).to_return_json(body: to_strapi_collection(
      Array.new(5) { Cms::Mocks::BlogTag.generate_raw_data }
    ))
  end

  def stub_strapi_media_upload
    stub_request(:post, /^https:\/\/strapi.teachcomputing.org\/api\/upload/).to_return_json(body: Cms::Mocks::Image.generate_raw_data)
  end

  def stub_strapi_media_query
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/upload\/files/).to_return_json(body: [Cms::Mocks::Image.generate_raw_data])
  end

  def stub_strapi_update(resource_key)
    stub_request(:put, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}/).to_return_json(body: {})
  end

  def stub_strapi_create(resource_key)
    stub_request(:post, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}/).to_return_json(body: {})
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

  def stub_strapi_blog_collection(blogs: nil)
    blog_list = blogs.presence || Array.new(5) { Cms::Mocks::Blog.generate_raw_data }
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/blogs/).to_return_json(body: to_strapi_collection(
      blog_list
    ))
  end

  def stub_strapi_blog_collection_with_tag(tag)
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/blogs\?.*(filters\[blog_tags\]\[slug\]\[\$eq\]=#{tag}).*/).to_return_json(body: to_strapi_collection(
      Array.new(5) { Cms::Mocks::Blog.generate_raw_data }
    ))
  end

  def stub_strapi_aside_section(key)
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/aside-sections\/#{key}/).to_return_json(body: to_strapi_data_structure(Cms::Mocks::AsideSection.generate_data(slug: key)))
  end

  def stub_strapi_aside_section_missing(key)
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/aside-sections\/#{key}/).to_return_json(body: not_found_response, status: 404)
  end

  def stub_strapi_enrichment_page(key)
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/enrichment-pages\/#{key}/)
      .to_return_json(body: {data: Cms::Mocks::EnrichmentPage.generate_raw_data(slug: key)})
  end

  def stub_strapi_web_page(key)
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/web-pages\/#{key}/).to_return_json(body: to_strapi_data_structure({
      pageTitle: Cms::Mocks::PageTitle.generate_raw_data,
      seo: Cms::Mocks::Seo.generate_raw_data,
      pageContent: [
        Cms::Mocks::FullWidthBanner.generate_raw_data
      ]
    }))
  end

  private

  def to_strapi_collection(records, page: 1, page_size: 10, page_count: 1)
    {
      data: records,
      meta: {
        pagination: {
          page: page,
          pageSize: page_size,
          pageCount: page_count,
          total: records.count
        }
      }
    }
  end

  def to_strapi_data_structure(attributes)
    {
      data: {
        id: Faker::Number.number,
        attributes: attributes.merge({
          publishedAt: DateTime.now.to_s,
          createdAt: DateTime.now.to_s,
          updatedAt: DateTime.now.to_s
        })
      }
    }
  end

  def not_found_response
    {
      data: nil,
      error: {
        status: 404,
        name: "NotFoundError",
        message: "Not Found",
        details: {}
      }
    }
  end

  def empty_collection_response(page_size: 10)
    {
      data: [],
      meta: {
        pagination: {
          page: 1,
          pageSize: page_size,
          pageCount: 1,
          total: 0
        }
      }
    }
  end
end
