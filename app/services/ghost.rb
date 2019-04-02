require('rest-client')

class Ghost
  def initialize
    @ghost_api_endpoint = ENV['GHOST_API_ENDPOINT']
    @ghost_api_path = '/ghost/api/v2/'
    @ghost_api_key = ENV['GHOST_CONTENT_API_KEY']
  end

  def get_featured_posts(how_many = 2)
    request = api_url_prefix(:posts)
    params = {
      key: @ghost_api_key,
      filter: 'featured:true',
      limit: how_many,
      fields: 'title,url,feature_image,custom_excerpt,published_at'
    }

    begin
      result = RestClient.get(request, params: params).body

      featured_posts = ActiveSupport::JSON.decode(result)

      return featured_posts['posts']
    rescue RestClient::Exception => error
      Raven.capture_exception(error)
    rescue ActiveSupport::JSON.parse_error
      Raven.capture_message("Ghost API JSON Parse error for string: #{result}")
    end
    []
  end

  def api_url_prefix(endpoint)
    "#{@ghost_api_endpoint}/content/#{endpoint}/"
  end
end
