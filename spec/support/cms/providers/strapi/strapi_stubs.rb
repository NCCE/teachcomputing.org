module StrapiStubs
  GRAPH_SCHEMA = File.new("spec/support/cms/providers/strapi/schema.json").read.freeze

  def stub_strapi_get_single_entity(resource_key)
    json_response = File.new("spec/support/cms/providers/strapi/single_type_response.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}?/).to_return(body: json_response)
  end

  def stub_strapi_get_single_entity_with_preview(resource_key)
    json_response = File.new("spec/support/cms/providers/strapi/single_type_response_with_preview.json")
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}?/).to_return(body: json_response)
  end

  def stub_strapi_blog_post(slug, blog: nil)
    blog_post = blog.presence || Cms::Mocks::Collections::Blog.generate_raw_data(slug:)
    if as_graphql
      stub_strapi_graphql_query("blogs", blog_post)
    else
      stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/blog\/#{slug}?/).to_return_json(body: {data: blog_post})
    end
  end

  def stub_strapi_get_single_resource(resource_key, data: Cms::Mocks::Collections::Blog.generate_raw_data)
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}?/).to_return_json(body: {data: data})
  end

  def stub_strapi_get_single_unpublished_blog_post(resource_key)
    unpublished_post = Cms::Mocks::Collections::Blog.generate_raw_data(slug: resource_key, publish_date: nil, published_at: nil)
    if as_graphql
      stub_strapi_graphql_query("blogs", unpublished_post)
    else
      stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}?/).to_return_json(body: {
        data: unpublished_post
      })
    end
  end

  def stub_strapi_get_collection_entity(resource_key)
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}?/).to_return_json(body: to_strapi_collection(
      Array.new(5) { Cms::Mocks::Collections::BlogTag.generate_raw_data }
    ))
  end

  def stub_strapi_get_empty_collection_entity(resource_key)
    if as_graphql
      stub_strapi_graphql_collection_query_missing(rest_resource_name_to_graph(resource_key))
    else
      stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}?/).to_return_json(body: empty_collection_response)
    end
  end

  def stub_strapi_not_found(resource_key)
    if as_graphql
      stub_strapi_graphql_query_missing(rest_resource_name_to_graph(resource_key))
    else
      stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/#{resource_key}*/).to_return_json(body: not_found_response, status: 404)
    end
  end

  def stub_strapi_media_upload
    stub_request(:post, /^https:\/\/strapi.teachcomputing.org\/api\/upload/).to_return_json(body: Cms::Mocks::ImageComponents::Image.generate_raw_data)
  end

  def stub_strapi_media_query
    stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/upload\/files/).to_return_json(body: [Cms::Mocks::ImageComponents::Image.generate_raw_data])
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
    if as_graphql
      stub_request(:post, /^https:\/\/strapi.teachcomputing.org\/graphql/)
        .to_return(status: [500, "Internal Server Error"])
    else
      stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/blogs/)
        .to_return(status: [500, "Internal Server Error"])
    end
  end

  def stub_strapi_blog_collection(blogs: nil, page: 1, page_size: 10)
    blog_list = if blogs.nil?
      Array.new(5) { Cms::Mocks::Collections::Blog.generate_raw_data }
    else
      blogs
    end

    if as_graphql
      stub_strapi_graphql_collection_query("blogs", blog_list, page:, page_size:)
    else
      stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/blogs/).to_return_json(body: to_strapi_collection(blog_list, page:, page_size:))
    end
  end

  def stub_strapi_blog_collection_with_tag(tag)
    blogs = Array.new(5) { Cms::Mocks::Collections::Blog.generate_raw_data }
    if as_graphql
      stub_strapi_graphql_collection_query("blogs", blogs)
    else
      stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/blogs\?.*(filters\[blog_tags\]\[slug\]\[\$eq\]=#{tag}).*/).to_return_json(body: to_strapi_collection(blogs))
    end
  end

  def stub_strapi_aside_section(key, aside_data: {})
    aside_section = Cms::Mocks::Collections::AsideSection.generate_raw_data(slug: key, **aside_data)
    if as_graphql
      stub_strapi_graphql_query("asideSections", aside_section, unique_key: key)
    else
      stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/aside-sections\/#{key}/).to_return_json(body: aside_section)
    end
  end

  def stub_strapi_aside_section_missing(key)
    if as_graphql
      stub_strapi_graphql_query_missing("asideSections")
    else
      stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/aside-sections\/#{key}/).to_return_json(body: not_found_response, status: 404)
    end
  end

  def stub_strapi_enrichment_page(key, enrichment_page: nil)
    enrichment_page = enrichment_page.presence || Cms::Mocks::Collections::EnrichmentPage.generate_raw_data(slug: key)
    if as_graphql
      stub_strapi_graphql_query("enrichmentPages", enrichment_page)
    else
      stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/enrichment-pages\/#{key}/)
        .to_return_json(body: {data: enrichment_page})
    end
  end

  def stub_strapi_enrichment_collection(enrichment_pages: Array.new(2) { Cms::Mocks::Collections::EnrichmentPage.generate_raw_data })
    if as_graphql
      stub_strapi_graphql_collection_query("enrichmentPages", enrichment_pages)
    else
      stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/enrichment-pages/)
        .to_return_json(body: to_strapi_collection(enrichment_pages))
    end
  end

  def stub_strapi_primary_computing_glossary_table_collection(table: nil, page: 1, page_size: 10)
    table_list = table.presence || Array.new(5) { Cms::Mocks::Collections::PrimaryGlossaryTableItems.generate_raw_data }
    if as_graphql
      stub_strapi_graphql_collection_query("primaryComputingGlossaryTables", table_list, page:, page_size:)
    else
      stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/primary-computing-glossary-tables/).to_return_json(body: to_strapi_collection(table_list, page:, page_size:))
    end
  end

  def stub_strapi_secondary_question_bank_collection(topic: nil, page: 1, page_size: 10)
    topic_list = topic.presence || Array.new(5) { Cms::Mocks::SecondaryQuestionBankTopic.generate_raw_data }
    if as_graphql
      stub_strapi_graphql_collection_query("secondaryQuestionBankTopics", topic_list, page:, page_size:)
    else
      stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/secondary-question-bank-topics/).to_return_json(body: to_strapi_collection(topic_list, page:, page_size:))
    end
  end

  def stub_strapi_web_page_collection(web_pages: nil)
    web_page_list = web_pages.presence || Array.new(5) { Cms::Mocks::Collections::WebPage.generate_raw_data }
    if as_graphql
      stub_strapi_graphql_collection_query("webPages", web_page_list)
    else
      stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/web-pages/).to_return_json(body: to_strapi_collection(web_page_list))
    end
  end

  def stub_strapi_web_page(key, page: Cms::Mocks::Collections::WebPage.generate_raw_data)
    if as_graphql
      stub_strapi_graphql_query("webPages", page)
    else
      stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/web-pages\/#{key}/).to_return_json(body: {data: page})
    end
  end

  def stub_strapi_web_page_not_found(key)
    if as_graphql
      stub_strapi_graphql_query_missing("webPages")
    else
      stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/web-pages\/#{key}/).to_return_json(body: not_found_response, status: 404)
    end
  end

  def stub_strapi_email_template(key, email_template: Cms::Mocks::EmailComponents::EmailTemplate.generate_raw_data)
    if as_graphql
      stub_strapi_graphql_query("emailTemplates", email_template, unique_key: key)
    else
      stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/email-templates\/#{key}/).to_return_json(body: {data: email_template})
    end
  end

  def stub_strapi_programme(key, programme: Cms::Mocks::Collections::Programme.generate_raw_data)
    if as_graphql
      stub_strapi_graphql_query("programmes", programme)
    else
      stub_request(:get, /^https:\/\/strapi.teachcomputing.org\/api\/programmes\/#{key}/).to_return_json(body: {data: programme})
    end
  end

  def stub_strapi_header(header: Cms::Mocks::Singles::Header.generate_raw_data)
    if as_graphql
      stub_strapi_graphql_query("header", header, singular: true)
    end
  end

  def stub_strapi_homepage(homepage: Cms::Mocks::Singles::Homepage.generate_raw_data)
    if as_graphql
      stub_strapi_graphql_query("homepage", homepage, singular: true)
    end
  end

  def stub_strapi_schema
    stub_request(:post, /^https:\/\/strapi.teachcomputing.org\/graphql/)
      .with(body: /IntrospectionQuery/)
      .to_return_json(body: GRAPH_SCHEMA)
  end

  def stub_strapi_graphql_query(resource_name, record, unique_key: nil, singular: false)
    stub_strapi_schema
    response = {}
    response[resource_name] = if singular
      {data: record}
    else
      {data: Array.wrap(record)}
    end
    stub = stub_request(:post, /^https:\/\/strapi.teachcomputing.org\/graphql/)
      .with(body: /#{resource_name}/)
      .to_return_json(body: {data: response})
    if unique_key
      stub.with(body: /#{unique_key}/)
    end
    stub
  end

  def stub_strapi_graphql_collection_query(resource_name, records, page: 1, page_size: 100)
    stub_strapi_schema
    response = {}
    response[resource_name] = to_strapi_collection(records, page:, page_size:)
    stub_request(:post, /^https:\/\/strapi.teachcomputing.org\/graphql/)
      .with(body: /#{resource_name}.*page:\s*#{page}/)
      .to_return_json(body: {data: response})
  end

  def stub_strapi_graphql_collection_query_missing(resource_name)
    stub_strapi_schema
    response = {}
    response[resource_name] = to_strapi_collection([])
    stub_request(:post, /^https:\/\/strapi.teachcomputing.org\/graphql/)
      .with(body: /#{resource_name}/)
      .to_return_json(body: {data: response})
  end

  def stub_strapi_graphql_query_missing(resource_name)
    stub_strapi_schema
    response = {}
    response[resource_name] = {data: []}
    stub_request(:post, /^https:\/\/strapi.teachcomputing.org\/graphql/)
      .with(body: /#{resource_name}/)
      .to_return_json(body: {data: response})
  end

  def stub_strapi_graphql_collection_error(resource_name)
    stub_strapi_schema
    response = {errors: [{message: "Not found"}]}
    stub_request(:post, /^https:\/\/strapi.teachcomputing.org\/graphql/)
      .with(body: /#{resource_name}/)
      .to_return_json(body: response)
  end

  private

  def rest_resource_name_to_graph(resource_key)
    resource_name = resource_key.include?("/") ? resource_key.split("/").first : resource_key
    resource_name.tr("-", "_").camelize(:lower)
  end

  def as_graphql
    Rails.application.config.strapi_connection_type == "graphql"
  end

  def to_strapi_collection(all_records, page: 1, page_size: 10, page_count: 1)
    records = all_records.slice(((page - 1) * page_size)..((page * page_size) - 1))
    {
      data: records.presence || [],
      meta: {
        pagination: {
          page: page,
          pageSize: page_size,
          pageCount: page_count,
          total: all_records.count
        }
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
