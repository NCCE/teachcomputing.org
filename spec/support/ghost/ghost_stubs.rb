module GhostStubs
  def stub_featured_posts
    raw_featured_posts_json = File.new('spec/support/ghost/featured_posts.json')
      stub_request(:get, "#{ENV['GHOST_API_ENDPOINT']}/content/posts/")
        .with(query: hash_including({ 'filter' => 'featured:true' }))
        .to_return(body: raw_featured_posts_json)
  end

  def stub_featured_posts_error
    stub_request(:get, "#{ENV['GHOST_API_ENDPOINT']}/content/posts/")
        .with(query: hash_including({ 'filter' => 'featured:true' }))
        .to_return(status: [500, "Internal Server Error"])
  end

  def stub_cms_page
    raw_page_json = File.new('spec/support/ghost/page.json')
    stub_request(:get, "#{ENV['GHOST_API_ENDPOINT']}/content/pages/slug/bursary/")
      .with(query: hash_including({ 'key' => "#{ENV['GHOST_CONTENT_API_KEY']}" }))
      .to_return(body: raw_page_json)
  end

  def stub_missing_cms_page
    raw_missing_page_json = File.new('spec/support/ghost/missing_page.json')
    stub_request(:get, "#{ENV['GHOST_API_ENDPOINT']}/content/pages/slug/bursary/")
      .with(query: hash_including({ 'key' => "#{ENV['GHOST_CONTENT_API_KEY']}" }))
      .to_return(body: raw_missing_page_json)
  end
end
