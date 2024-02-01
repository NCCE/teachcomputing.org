module GhostStubs
  def stub_featured_posts
    raw_featured_posts_json = File.new("spec/support/ghost/featured_posts.json")
    stub_request(:get, "#{ENV["GHOST_API_ENDPOINT"]}/content/posts/")
      .with(query: hash_including({"filter" => "featured:true"}))
      .to_return(body: raw_featured_posts_json)
  end

  def stub_featured_posts_error
    stub_request(:get, "#{ENV["GHOST_API_ENDPOINT"]}/content/posts/")
      .with(query: hash_including({"filter" => "featured:true"}))
      .to_return(status: [500, "Internal Server Error"])
  end

  def stub_cms_page
    raw_page_json = File.new("spec/support/ghost/page.json")
    stub_request(:get, "#{ENV["GHOST_API_ENDPOINT"]}/content/pages/slug/funding/")
      .with(query: hash_including({"key" => (ENV["GHOST_CONTENT_API_KEY"]).to_s}))
      .to_return(body: raw_page_json)
  end

  def stub_cms_post
    raw_page_json = File.new("spec/support/ghost/post.json")
    stub_request(:get, "#{ENV["GHOST_API_ENDPOINT"]}/content/posts/slug/funding/")
      .with(query: hash_including({"key" => (ENV["GHOST_CONTENT_API_KEY"]).to_s}))
      .to_return(body: raw_page_json)
  end

  def stub_nested_cms_page
    raw_page_json = File.new("spec/support/ghost/page.json")
    stub_request(:get,
      "#{ENV["GHOST_API_ENDPOINT"]}/content/pages/slug/subject-practitioners-primary/")
      .with(query: hash_including({"key" => (ENV["GHOST_CONTENT_API_KEY"]).to_s}))
      .to_return(body: raw_page_json)
  end

  def stub_missing_cms_page
    raw_missing_page_json = File.new("spec/support/ghost/missing_post.json")
    stub_request(:get, "#{ENV["GHOST_API_ENDPOINT"]}/content/pages/slug/eggs/")
      .with(query: hash_including({"key" => (ENV["GHOST_CONTENT_API_KEY"]).to_s}))
      .to_return(body: raw_missing_page_json)
  end

  def stub_missing_cms_post
    raw_missing_page_json = File.new("spec/support/ghost/missing_post.json")
    stub_request(:get, "#{ENV["GHOST_API_ENDPOINT"]}/content/posts/slug/eggs/")
      .with(query: hash_including({"key" => (ENV["GHOST_CONTENT_API_KEY"]).to_s}))
      .to_return(body: raw_missing_page_json)
  end

  def stub_cms_articles
    raw_post_json = File.new("spec/support/ghost/post.json")
    stub_request(:get, "#{ENV["GHOST_API_ENDPOINT"]}/content/posts?fields=title,slug,feature_image,custom_excerpt,excerpt,published_at&key=key&limit=all&page=1")
      .to_return(body: raw_post_json)

    raw_page_json = File.new("spec/support/ghost/page.json")
    stub_request(:get, "#{ENV["GHOST_API_ENDPOINT"]}/content/pages?fields=title,slug,feature_image,custom_excerpt,excerpt,published_at&key=key&limit=all&page=1")
      .to_return(body: raw_page_json)
  end
end
