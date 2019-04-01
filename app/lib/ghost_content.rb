require('rest-client')

class GhostContent
  def initialize
    @ghost_host = 'https://teachcomputing.ghost.io'
    @ghost_api_path = '/ghost/api/v2/'
    @ghost_api_key = ENV['GHOST_CONTENT_API_KEY']
  end

  def get_featured_posts(how_many = 2)
      request = api_url_prefix(:posts)
      request += "&filter=featured:true"
      request += "&limit=#{how_many}"
      request += "&fields=title,url,feature_image,custom_excerpt,published_at"
      
      result = RestClient.get(request).body

      featured_posts = ActiveSupport::JSON.decode(result)

      featured_posts['posts']
  end

  def api_url_prefix(endpoint)
    "#{@ghost_host}#{@ghost_api_path}content/#{endpoint}/?key=#{@ghost_api_key}"
  end
end