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
end
